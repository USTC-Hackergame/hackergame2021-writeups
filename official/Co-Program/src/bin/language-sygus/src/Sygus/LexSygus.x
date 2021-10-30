{
module Sygus.LexSygus ( Token (..) 
                      , Lit (..)
                      , lexSygus ) where

import Sygus.Syntax

}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$symbs = [\_ \+ \- \* \& \| \! \~ \< \> \= \/ \% \? \. \$ \^]

tokens:-
    $white+                                 ;
    $digit+'.'$digit                        { TLit. parseDec }
    $digit+                                 { TLit . LitNum . read }
    true                                    { TLit . const (LitBool True) }
    false                                   { TLit . const (LitBool False) }
    \#x[$digit A-F]+                        { TLit . Hexidecimal }
    \#b[01]+                                { TLit . Binary }
    \"[$alpha $digit $symbs $white ]* \"    { TLit . LitStr . elimOpenCloseQuote }
    \_$white+                               { const TUnderscore }
    \(                                      { const TOpenBracket }
    \)                                      { const TCloseBracket }
    \:                                      { const TColon }

    [$alpha $symbs][$alpha $digit $symbs]*  { TSymbol }


{
data Token = TLit Lit
           | TUnderscore
           | TOpenBracket
           | TCloseBracket
           | TColon
           | TSymbol String
           deriving (Show, Read)

lexSygus :: String -> [Token]
lexSygus = alexScanTokens

elimOpenCloseQuote :: String -> String
elimOpenCloseQuote ('"':xs) = elimOpenCloseQuote' xs
elimOpenCloseQuote _ = error "elimOpenCloseQuote: Bad string"

elimOpenCloseQuote' :: String -> String
elimOpenCloseQuote' ('"':[]) = []
elimOpenCloseQuote' (x:xs) = x:elimOpenCloseQuote' xs
elimOpenCloseQuote' [] = error "elimOpenCloseQuote': Bad string"

parseDec :: String -> Lit
parseDec s =
  let
      (n, _:d) = break (== '.') s
  in
  LitDec (read n) (read d)

}