module Parser where

import           Control.Monad.Combinators.Expr
import           Data.Void
import qualified Language as L
import           Text.Megaparsec hiding (parse)
import qualified Text.Megaparsec as P
import           Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as Lex

type Parser = Parsec Void String

sc :: Parser ()
sc = Lex.space space1 (Lex.skipLineComment "//") (Lex.skipBlockComment "/*" "*/")

lexeme :: Parser a -> Parser a
lexeme = Lex.lexeme sc

symbol :: String -> Parser String
symbol = Lex.symbol sc

var :: Parser L.Expr
var = L.Var <$> lexeme ((:) <$> letterChar <*> many alphaNumChar <?> "variable")

int :: Parser L.Expr
int = L.Int <$> lexeme Lex.decimal

ite :: Parser L.Expr
ite = do
  symbol "if"
  symbol "("
  c <- expr
  symbol ","
  a <- expr
  symbol ","
  b <- expr
  symbol ")"
  pure $ L.If c a b

parens :: Parser a -> Parser a
parens = between (symbol "(") (symbol ")")

term :: Parser L.Expr
term = choice
  [ parens expr
  , ite
  , var
  , int
  ]

expr :: Parser L.Expr
expr = makeExprParser term operatorTable

operatorTable :: [[Operator Parser L.Expr]]
operatorTable =
  [ [ prefix "-" L.Neg
    , prefix "+" id
    ]
  , [ binary "*" L.Mul
    , binary "/" L.Div
    , binary "%" L.Mod
    ]
  , [ binary "+" L.Add
    , binary "-" L.Sub
    ]
  , [ binary "<=" L.Le
    , binary "=" L.Eq
    ]
  , [ prefix "!" L.Not ]
  , [ binary "&&" L.And ]
  , [ binary "||" L.Or ]
  ]

binary :: String -> (L.Expr -> L.Expr -> L.Expr) -> Operator Parser L.Expr
binary  name f = InfixL  (f <$ symbol name)

prefix, postfix :: String -> (L.Expr -> L.Expr) -> Operator Parser L.Expr
prefix  name f = Prefix  (f <$ symbol name)
postfix name f = Postfix (f <$ symbol name)

parse :: String -> Maybe L.Expr
parse str = case (P.parse expr "" str) of
  Left _  -> Nothing
  Right e -> Just e
