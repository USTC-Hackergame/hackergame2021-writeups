module Main where

import qualified Challenge1 as C1
import qualified Challenge2 as C2
import           System.Environment
import           System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin NoBuffering
  args <- getArgs
  if args!!0 == "1"
    then C1.main stdin stdout
    else C2.main stdin stdout
