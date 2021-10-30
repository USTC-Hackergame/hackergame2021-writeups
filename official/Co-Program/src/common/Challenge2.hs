{-# LANGUAGE OverloadedLists #-}

module Challenge2 where

import           Control.Monad
import           Control.Monad.Random.Class
import           Data.IORef
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe
import qualified Data.Set as S
import           Gen
import           Language (Word36)
import qualified Language as L
import           Parser (parse)
import           Prelude hiding (putStrLn, getLine)
import           System.IO
import           System.Timeout
import           Text.Printf

total :: Int
total = 10

threshold :: Int
threshold = 7

main :: Handle -> Handle -> IO ()
main hIn hOut = do
  solvedCnt <- newIORef (0 :: Int)
  replicateM total $ do
    c <- genChallenge
    printChallenge hOut c
    n <- readIORef solvedCnt
    timeout 30_000_000 (getInput hIn) >>= \case
      Nothing -> hPutStrLn hOut $ printf "Timeout! You only have 30 seconds for one challenge! You have co-programmed %d functions so far." n
      Just userAns -> do
        success <- case checkAnswer c userAns of
                     Left err -> hPutStrLn hOut err >> return False
                     Right _ -> return True
        if success
          then do { writeIORef solvedCnt (n+1)
                  ; hPutStrLn hOut (printf "OK! You've solved %d out of %d" (n+1) total)
                  }
          else hPutStrLn hOut (printf "Oh no! This test failed! You've solved %d out of %d" n total)

  finalSolved <- readIORef solvedCnt
  if finalSolved >= threshold
    then printFlag hOut
    else hPutStrLn hOut "You are NOT a true co-programmer! Who are you!"

data Challenge = Challenge
  { groundTruth :: L.Expr
  , values :: [((Word36, Word36), Word36)]
  } deriving Show

ctx :: Word36 -> Word36 -> L.Ctx
ctx x y = M.fromList $ [ ("x", x), ("y", y) ]

genChallenge :: IO Challenge
genChallenge = do
  func <- Gen.randomFuncWithDepth 5
  xyPairs <- replicateM 5 (getRandom :: IO (Word36, Word36))
  let vals = map (\(x,y) -> fromJust $ L.interpret (ctx x y) func) xyPairs
  return (Challenge func (zip xyPairs vals))

printChallenge :: Handle -> Challenge -> IO ()
printChallenge hOut chan = do
  hPutStrLn hOut ""
  hPutStrLn hOut "Challenge!"
  mapM_ (hPutStrLn hOut . showValuePair) (values chan)
  where showValuePair ((x, y), ans) = printf "x=%s, y=%s, ans=%s" (show x) (show y) (show ans)
          -- printf "(constraint (= (f %s %s) %s))" (show36 x) (show36 y) (show36 ans)
        -- show36 x = ppSExpr (bvHex 36 (fromIntegral x)) ""

getInput :: Handle -> IO String
getInput = hGetLine

printFlag :: Handle -> IO ()
printFlag hOut = do
  flag <- readFile "/root/flag2"
  hPutStrLn hOut $ printf "You are truly a heroic co-programmer!! Your certificate number is: %s\n" flag

checkAnswer :: Challenge -> String -> Either String ()
checkAnswer chan exprStr = do
  expr <- case parse exprStr of
    Nothing -> fail "Parse Error! Check your input plz..."
    Just x -> return x

  case L.typeCheck expr of
    Just L.TInt -> pure ()
    _ -> fail "Type check failed!! Check your input plz..."

  if L.containsConsts expr
    then fail "What?! I said no integer constants! I trusted you!!"
    else pure ()
  
  let vars = L.freeVars expr
  if S.fromList vars `S.isSubsetOf` ["x", "y"]
    then pure ()
    else fail (printf "Only x and y are usable free variables, you used: %s" (intercalate " " vars))
  foldM (check expr) () (values chan)

  where check expr _ ((x,y),ans) = do
          let val = fromJust $ L.interpret (ctx x y) expr
          if val == ans
            then pure ()
            else fail (printf "for input x=%s, y=%s, expected output=%s, but your function returned %s"
                       (show x) (show y) (show ans) (show val))

-- make it look better
instance MonadFail (Either String) where
  fail x = Left x
