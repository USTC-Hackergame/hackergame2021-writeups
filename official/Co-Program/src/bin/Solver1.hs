module Main where

import           Control.Monad
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Maybe
import           Data.List.Split
import qualified Data.Map.Strict as M
import           Data.Maybe
import qualified Language as L
import           Network.Run.TCP
import           Network.Socket
import qualified Parser as P
import qualified SimpleSMT as S
import           System.Environment
import           System.IO
import           System.Timeout
import           Text.Printf
import           Text.Read (readMaybe)


exprToSMT :: L.Expr -> S.SExpr
exprToSMT (L.Int i) = S.bvHex 36 (fromIntegral i)
exprToSMT (L.Var v) = S.const v
exprToSMT (L.Neg x) = S.bvNeg (exprToSMT x)
exprToSMT (L.Add x y) = S.bvAdd (exprToSMT x) (exprToSMT y)
exprToSMT (L.Sub x y) = S.bvSub (exprToSMT x) (exprToSMT y)
exprToSMT (L.Mul x y) = S.bvMul (exprToSMT x) (exprToSMT y)
exprToSMT (L.Div x y) = S.bvUDiv (exprToSMT x) (exprToSMT y)
exprToSMT (L.Mod x y) = S.bvURem (exprToSMT x) (exprToSMT y)


defaultTimeout :: Int
defaultTimeout = 10_000_000  -- 10秒


main :: IO ()
main = do
  token <- getEnv "TOKEN"
  runTCPClient "127.0.0.1" "10700" $ \s -> do
    server   <- socketToHandle s ReadWriteMode
    hPutStrLn server token
    hGetContents server >>= sequence_ . map (solve server) . chunksOf 2 . drop 1 . lines


solve :: Handle -> [String] -> IO ()
solve _ [] = pure ()
solve _ [l] = printf "verdict: %s\n" l
solve h [exprStr,answerStr] = (hPutStrLnTrace h . fromMaybe "" =<<) $ runMaybeT $ do   -- what the fuck
  liftIO $ printf "\n\nQ: %s, %s\n" exprStr answerStr
  expr     <- liftMaybe $ P.parse exprStr
  answer   <- liftMaybe $ L.word36 <$> (readMaybe answerStr)
  solution <- joinMaybe . liftIO $ solveConstants expr answer
  liftIO $ print solution
  return . unwords $ [ printf "%s=%s" var (show val) | (var, val) <- M.toList solution ]
  where hPutStrLnTrace h str = putStrLn str >> hPutStrLn h str
solve _ (_:_:_:_) = error "unreachable"


solveConstants :: MonadIO m => L.Expr -> L.Word36 -> m (Maybe L.Ctx)
solveConstants expr (L.Word36 output) = liftIO $ do
  solver <- S.newSolver "cvc5" ["--produce-models", "--lang=smtlib2"] Nothing
  -- solver <- S.newSolver "z3" ["-in"] Nothing
  S.setLogic solver "QF_UFBV"
  -- Declare a constant for every free variable.
  let vars = L.freeVars expr
  forM_ (L.freeVars expr) $ \var -> do
    void $ S.declare solver var (S.tBits 36)
  -- Assert the output.
  S.assert solver ((exprToSMT expr) `S.eq` (S.bvHex 36 output))
  timeout defaultTimeout (S.check solver) >>= \case
    Nothing        -> return Nothing
    Just S.Unsat   -> return Nothing
    Just S.Unknown -> return Nothing
    Just S.Sat     -> do
      model <- S.getConsts solver vars
      return . Just . M.fromList $ map (\(var, S.Bits _ val) -> (var, L.word36 val)) model


------------------------------------------------------------------------
liftMaybe :: MonadPlus m => Maybe a -> MaybeT m a
liftMaybe = maybe mzero return

joinMaybe :: MonadPlus m => MaybeT m (Maybe a) -> MaybeT m a
joinMaybe = (>>= liftMaybe)

