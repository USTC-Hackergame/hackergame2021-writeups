module Challenge1 where

import           Control.Monad
import           Control.Monad.Random.Class
import           Data.List.Split
import qualified Data.Map.Strict as M
import           Gen
import qualified Language as L
import           System.Exit
import           System.IO
import           System.Timeout
import           Text.Read

type Challenge = (L.Expr, L.Ctx, L.Word36)

threshold :: Int
threshold = 90

main :: Handle -> Handle -> IO ()
main hin hout = do
  welcome hout
  results <- timeout (120_000_000) $ do  -- 120秒超时
    cs <- challenges
    forM cs $ \c@(expr, _ctx, answer) -> do
      printChallenge hout c
      input <- map partsToMaybePair . map (splitOn "=") . words <$> (hGetLine hin)
      case sequence input of
        Nothing -> return False
        Just vals -> let ctx' = M.fromList vals in
          return $ L.interpret ctx' expr == Just answer
  case length . filter (==True) <$> results of
    Nothing -> hPutStrLn hout "sus, reported" >> exitFailure
    Just num -> if num < threshold
                then hPutStrLn hout ("sus... try again? you got " <> show num <> " right") >> exitFailure
                else hPutStr hout ("you got " <> show num <> " right, ") >> printFlag hout
  where partsToMaybePair []        = Nothing
        partsToMaybePair [_]       = Nothing
        partsToMaybePair (v:val:_) = readMaybe val >>= Just . ((,) v) . L.word36

welcome :: Handle -> IO ()
welcome h = hPutStrLn h "Welcome to Macrohard 36-bit computer!"

printFlag :: Handle -> IO ()
printFlag h = readFile "/root/flag1" >>= hPutStr h . ("OK, your passcode is: " <>) >> hFlush h

challenges :: IO [Challenge]
challenges = forM [1..100::Int] $ \i -> challenge (varsFor i) (depthFor i)
  where depthFor i | i < 10    = 2
                   | i < 70    = 3
                   | otherwise = 4
        varsFor i | i < 30    = ["x", "y", "z", "i", "j", "k"]
                  | i < 60    = ["x", "y", "z", "i", "j"]
                  | otherwise = ["x", "y", "z", "i"]

challenge :: [String] -> Int -> IO Challenge
challenge vars depth = do
  expr <- Gen.randomExprWithDepth vars depth
  ctx  <- genCtx vars
  let Just answer = L.interpret ctx expr
  return (expr, ctx, answer)

genCtx :: [String] -> IO L.Ctx
genCtx vars = do
  values <- traverse (const getRandom) vars
  return . M.fromList $ (zip vars values)

printChallenge :: Handle -> Challenge -> IO ()
printChallenge h (expr, _ctx, answer) = do
  hPutStrLn h $ show expr
  hPutStrLn h $ show answer
