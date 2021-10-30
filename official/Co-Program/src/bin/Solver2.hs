{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE QuasiQuotes #-}
module Main where

import           Control.Applicative
import           Control.Concurrent
import           Control.IO.Region (region)
import qualified Control.IO.Region as R
import           Control.Monad
import           Control.Monad.Trans.Reader
import           Data.List
import           Data.Map (Map)
import qualified Data.Map as M
import           Language
import           Network.Run.TCP
import           Network.Socket
import           SimpleSMT hiding (Bool)
import           Sygus.LexSygus
import           Sygus.ParseSygus
import           System.Environment
import           System.IO
import           System.Process
import           System.Timeout
import           Text.Printf
import           Text.Scanf (scanf, (:+)(..), fmt)

genSyFile :: [(Integer, Integer, Integer)] -> String
genSyFile vals =
  printf "(set-logic BV)\n\
         \(synth-fun f ((x (_ BitVec 36)) (y (_ BitVec 36))) (_ BitVec 36)\n\
         \           ((Start (_ BitVec 36)) (StartBool Bool))\n\
         \           ((Start (_ BitVec 36) (x y\n\
         \                                  (bvadd Start Start)\n\
         \                                  (bvsub Start Start)\n\
         \                                  (bvmul Start Start)          \n\
         \                                  (bvudiv Start Start)         \n\
         \                                  (bvurem Start Start)         \n\
         \                                  (bvneg Start)                \n\
         \                                  (ite StartBool Start Start)))\n\
         \            (StartBool Bool (true false                          \n\
         \                             (bvule Start Start)            \n\
         \                             (= Start Start)                \n\
         \                             (and StartBool StartBool)      \n\
         \                             (or StartBool StartBool)       \n\
         \                             (not StartBool)))))            \n\
         \%s\n\
         \(check-synth)\n" (intercalate "\n" valStrs)
  where valStrs :: [String]
        valStrs = map (\(x,y,ans) -> printf "(constraint (= (f %s %s) %s))" (show36 x) (show36 y) (show36 ans)) vals
        show36 x = ppSExpr (bvHex 36 x) ""

getOne :: Handle -> IO (Integer, Integer, Integer)
getOne h = do
  Just (x :+ y :+ ans :+ ()) <- hGetLine h >>= return . scanf [fmt|x=%l, y=%l, ans=%l|]
  return (x,y,ans)

syFunToExpr :: Cmd -> Expr
syFunToExpr (SmtCmd (DefineFun _ _ _ term)) = runReader (syTermToExpr term) (M.fromList [])
syFunToExpr _ = error "bad cmd"

syTermToExpr :: Term -> Reader (Map String Expr) Expr
syTermToExpr (TermIdent (ISymb v)) = do
  env <- ask
  case M.lookup v env of
    Just expr -> return expr
    Nothing -> return (Var v)
syTermToExpr (TermIdent (Indexed _ _)) = error "indexed"
syTermToExpr (TermLit (LitBool b)) = return $ Bool b
syTermToExpr (TermLit _) = error "lit"
syTermToExpr (TermCall (ISymb "bvsub") [x, y]) = liftA2 Sub (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "bvadd") [x, y]) = liftA2 Add (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "bvmul") [x, y]) = liftA2 Mul (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "bvudiv") [x, y]) = liftA2 Div (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "=") [x, y]) = liftA2 Eq (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "bvule") [x, y]) = liftA2 Le (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "bvurem") [x, y]) = liftA2 Mod (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "ite") [x, y, z]) = liftA3 If (syTermToExpr x) (syTermToExpr y) (syTermToExpr z)
syTermToExpr (TermCall (ISymb "bvneg") [x]) = liftA Neg (syTermToExpr x)
syTermToExpr (TermCall (ISymb "and") [x, y]) = liftA2 And (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "or") [x, y]) = liftA2 Or (syTermToExpr x) (syTermToExpr y)
syTermToExpr (TermCall (ISymb "not") [x]) = liftA Not (syTermToExpr x)
syTermToExpr (TermCall _ _) = error "bad term call"
syTermToExpr (TermExists _ _) = error "No exists"
syTermToExpr (TermForAll _ _) = error "No forall"
syTermToExpr (TermLet bindings term) = do
  cur <- ask
  let newVars = M.fromList $ map (\(VarBinding name term) -> (name, runReader (syTermToExpr term) cur)) bindings
  local (\old -> M.union newVars old) (syTermToExpr term)

solveOne :: [(Integer, Integer, Integer)] -> IO (Maybe Expr)
solveOne input = timeout 28_000_000 $ region $ \r -> do
  putStrLn "solving..."
  writeFile "/tmp/synth.sygus" (genSyFile input)
  (readEnd, writeEnd) <- createPipe
  R.alloc_ r (runProcess "cvc5" ["--lang=sygus2", "/tmp/synth.sygus"] Nothing Nothing Nothing (Just writeEnd) Nothing) terminateProcess
  !result <- hGetContents readEnd
  let syTree = parse . trim . lexSygus $ result
      expr = syFunToExpr (head syTree)
  return expr

trim :: [a] -> [a]
trim = reverse.tail.reverse.tail

solveMany :: Handle -> Handle -> IO ()
solveMany remoteIn remoteOut = forever $ do
  line <- hGetLine remoteIn
  putStrLn $ "S: " ++ line
  if line == "Challenge!"
    then do { vals <- replicateM 5 (getOne remoteIn)
            ; putStrLn ("Get new challenge: " ++ show vals)
            ; solveOne vals >>= \case
                Just solution -> do
                  putStrLn $ "Solved! " ++ show solution
                  hPutStrLn remoteOut (show solution)
                  hFlush remoteOut
                Nothing -> do
                  putStrLn "it took too long to solve!"
                  hPutStrLn remoteOut ""
                  hFlush remoteOut
            }
    else pure ()

-- main :: IO ()
-- main = do
--   (remoteOut, remoteIn, _, _) <- runInteractiveProcess "cabal" ["run", "server", "2"] Nothing Nothing
--   solveMany remoteIn remoteOut

main :: IO ()
main = do
  token <- getEnv "TOKEN"
  runTCPClient "127.0.0.1" "10800" $ \sock -> do
    remote <- socketToHandle sock ReadWriteMode
    hPutStrLn remote token
    solveMany remote remote
