{-# LANGUAGE OverloadedStrings #-}

module Main where

import Sygus.LexSygus
import Sygus.ParseSygus
import Sygus.Print

import Control.DeepSeq
import Data.Text (unpack)
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  pt <- parseTests
  pr <- parseAndPrintsTests
  defaultMain $ testGroup "all" [ pt, pr, printTests ]

parseTests :: IO TestTree
parseTests = return . testGroup "Parse" =<< mapM checkParses files

parseAndPrintsTests :: IO TestTree
parseAndPrintsTests =
    return . testGroup "Parse and print" =<< mapM checkParsesAndPrints files

printTests :: TestTree
printTests =
    testGroup "Print" [printTest1]

files :: [FilePath]
files =
    [ "tests/sygus/example1.sl"
    , "tests/sygus/example2.sl"
    , "tests/sygus/example3.sl"
    , "tests/sygus/example4.sl"
    , "tests/sygus/example5.sl"
    , "tests/sygus/example6.sl"
    , "tests/sygus/example7.sl"
    , "tests/sygus/example8.sl" ]

checkParses :: FilePath -> IO TestTree
checkParses fp = do
    s <- readFile fp
    let p = parse . lexSygus $ s

    return $ testCase fp
              $ assertBool fp
                (show p `deepseq` True)

checkParsesAndPrints :: FilePath -> IO TestTree
checkParsesAndPrints fp = do
    s <- readFile fp
    let p1 = parse . lexSygus $ s
        p2 = parse . lexSygus . unpack . printSygus $ p1

    return $ testCase fp
              $ assertBool fp
                (p1 == p2)

printTest1 :: TestTree
printTest1 = testCase "Negative Number"
              $ assertBool "Negative Number" (printSygus (LitNum (-1)) == "(- 1)")
