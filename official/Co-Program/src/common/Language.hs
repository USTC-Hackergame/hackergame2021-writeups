{-# LANGUAGE ApplicativeDo #-}
module Language
  ( Expr(..)
  , unaryOps, binaryOps
  , replaceVar, freeVars
  , interpret
  , Word36(..), word36, max36, mod36
  , typeCheck
  , containsConsts
  , Type(..)
  , Ctx)
where

import           Control.Applicative
import           Control.Monad
import           Data.List
import           Data.Map (Map)
import qualified Data.Map.Strict as M
import           System.Random.Stateful
import           Text.Printf

data Expr
  = Var String
  | Int Word36
  | Neg Expr
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr
  | Mod Expr Expr
  -- Boolean-related
  | Bool Bool
  | Le Expr Expr
  | Eq Expr Expr
  | And Expr Expr
  | Or  Expr Expr
  | Not Expr
  | If  Expr Expr Expr
  deriving (Eq, Ord)

unaryOps :: [Expr -> Expr]
unaryOps = [Neg]

binaryOps :: [Expr -> Expr -> Expr]
binaryOps = [Add, Sub, Mul, Div, Mod]

instance Show Expr where
  show (Var v) = v
  show (Int i) = show i
  show (Neg x) = printf "(-%s)" (show x)
  show (Add x y) = printf "(%s+%s)" (show x) (show y)
  show (Sub x y) = printf "(%s-%s)" (show x) (show y)
  show (Mul x y) = printf "(%s*%s)" (show x) (show y)
  show (Div x y) = printf "(%s/%s)" (show x) (show y)
  show (Mod x y) = printf "(%s%%%s)" (show x) (show y)
  show (Bool True) = "true"
  show (Bool False) = "false"
  show (Le x y) = printf "(%s<=%s)" (show x) (show y)
  show (Eq x y) = printf "(%s=%s)" (show x) (show y)
  show (And x y) = printf "(%s&&%s)" (show x) (show y)
  show (Or  x y) = printf "(%s||%s)" (show x) (show y)
  show (Not x)   = printf "(!%s)" (show x)
  show (If  x y z) = printf "if(%s,%s,%s)" (show x) (show y) (show z)

replaceVar :: String -> Expr -> Expr -> Expr
replaceVar from to e@(Var name) | name == from = to
                                | otherwise    = e
replaceVar _ _ e@(Int _) = e
replaceVar _ _ e@(Bool _) = e
replaceVar from to (Neg x) = Neg (replaceVar from to x)
replaceVar from to (Add x y) = Add (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Sub x y) = Sub (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Mul x y) = Mul (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Div x y) = Div (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Mod x y) = Mod (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Le x y) = Le (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Eq x y) = Eq (replaceVar from to x) (replaceVar from to y)
replaceVar from to (And x y) = And (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Or x y) = Or  (replaceVar from to x) (replaceVar from to y)
replaceVar from to (Not x) = Not (replaceVar from to x)
replaceVar from to (If x y z) = If (replaceVar from to x) (replaceVar from to y) (replaceVar from to z)

freeVars :: Expr -> [String]
freeVars (Var v) = [v]
freeVars (Int _) = []
freeVars (Bool _) = []
freeVars (Neg x) = nub $ freeVars x
freeVars (Add x y) = nub $ freeVars x ++ freeVars y
freeVars (Sub x y) = nub $ freeVars x ++ freeVars y
freeVars (Mul x y) = nub $ freeVars x ++ freeVars y
freeVars (Div x y) = nub $ freeVars x ++ freeVars y
freeVars (Mod x y) = nub $ freeVars x ++ freeVars y
freeVars (Le x y) = nub $ freeVars x ++ freeVars y
freeVars (Eq x y) = nub $ freeVars x ++ freeVars y
freeVars (And x y) = nub $ freeVars x ++ freeVars y
freeVars (Or  x y) = nub $ freeVars x ++ freeVars y
freeVars (Not x) = nub $ freeVars x
freeVars (If x y z) = nub $ freeVars x ++ freeVars y ++ freeVars z

containsConsts :: Expr -> Bool
containsConsts (Var _) = False
containsConsts (Int _) = True
containsConsts (Bool _) = False
containsConsts (Neg x) = containsConsts x
containsConsts (Not x) = containsConsts x
containsConsts (Add x y) = containsConsts x || containsConsts y
containsConsts (Sub x y) = containsConsts x || containsConsts y
containsConsts (Mul x y) = containsConsts x || containsConsts y
containsConsts (Div x y) = containsConsts x || containsConsts y
containsConsts (Mod x y) = containsConsts x || containsConsts y
containsConsts (And x y) = containsConsts x || containsConsts y
containsConsts (Or x y) = containsConsts x || containsConsts y
containsConsts (Le x y) = containsConsts x || containsConsts y
containsConsts (Eq x y) = containsConsts x || containsConsts y
containsConsts (If x y z) = containsConsts x || containsConsts y || containsConsts z

type Ctx = Map String Word36

interpret :: Ctx -> Expr -> Maybe Word36
interpret ctx (Var x) = M.lookup x ctx
interpret _   (Int x) = return x
interpret _   (Bool True) = return 1
interpret _   (Bool False) = return 0
interpret ctx (Neg x) = liftA (negate) (interpret ctx x)
interpret ctx (Add x y) = liftA2 (+) (interpret ctx x) (interpret ctx y)
interpret ctx (Sub x y) = liftA2 (-) (interpret ctx x) (interpret ctx y)
interpret ctx (Mul x y) = liftA2 (*) (interpret ctx x) (interpret ctx y)
interpret ctx (Div x y) = liftA2 div (interpret ctx x) (interpret ctx y)
interpret ctx (Mod x y) = liftA2 mod (interpret ctx x) (interpret ctx y)
interpret ctx (Le x y) = do
  a <- interpret ctx x
  b <- interpret ctx y
  return $ if a <= b then 1 else 0
interpret ctx (Eq x y) = do
  a <- interpret ctx x
  b <- interpret ctx y
  return $ if a == b then 1 else 0
interpret ctx (And x y) = liftA2 sand (interpret ctx x) (interpret ctx y)
  where sand a b = a * b
interpret ctx (Or x y ) = liftA2 sor  (interpret ctx x) (interpret ctx y)
  where sor 1 _ = 1
        sor _ a = a
interpret ctx (Not x) = liftA snot (interpret ctx x)
  where snot a = 1 - a
interpret ctx (If x y z) = liftA3 sif (interpret ctx x) (interpret ctx y) (interpret ctx z)
  where sif 1 a _ = a
        sif 0 _ b = b
        sif _ _ _ = error "unreachable"

data Type = TInt | TBool deriving Eq

typeIs :: Expr -> Type -> Maybe ()
typeIs expr ty = typeCheck expr >>= guard . (== ty)

-- |检查类型是否正确。如果不正确则返回 Nothing.
typeCheck :: Expr -> Maybe Type
typeCheck (Var _) = return TInt
typeCheck (Int _) = return TInt
typeCheck (Bool _) = return TBool
typeCheck (Add x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TInt
typeCheck (Sub x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TInt
typeCheck (Mul x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TInt
typeCheck (Div x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TInt
typeCheck (Mod x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TInt
typeCheck (Neg x) = x `typeIs` TInt >> return TInt
typeCheck (And x y) = x `typeIs` TBool >> y `typeIs` TBool >> return TBool
typeCheck (Or x y) = x `typeIs` TBool >> y `typeIs` TBool >> return TBool
typeCheck (Not x) = x `typeIs` TBool >> return TBool
typeCheck (Le x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TBool
typeCheck (Eq x y) = x `typeIs` TInt >> y `typeIs` TInt >> return TBool
typeCheck (If x y z) = x `typeIs` TBool >> y `typeIs` TInt >> z `typeIs` TInt >> return TInt

-- |2^36 - 1
max36 :: Word36
max36 = Word36 (2 ^ (36 :: Int) - 1)

-- N.B. Don't use this constructor!
newtype Word36 = Word36 Integer
  deriving (Eq, Ord)

instance Show Word36 where
  show (Word36 x) = show x

-- |Smart constructor of Word36.
word36 :: Integer -> Word36
word36 = fromInteger

-- |x `mod` (2^36)
mod36 :: Integer -> Integer
mod36 = (`mod` (2 ^ (36 :: Int)))

instance Num Word36 where
  (Word36 a) + (Word36 b) = Word36 . fromInteger . mod36 $ a + b
  (Word36 a) - (Word36 b) = Word36 . fromInteger . mod36 $ a - b
  (Word36 a) * (Word36 b) = Word36 . fromInteger . mod36 $ a * b
  abs (Word36 a) = Word36 . fromInteger . mod36 $ abs a
  signum (Word36 a) = Word36 $ if | a == 0    -> 0
                                  | otherwise -> 1  -- unsigned!
  fromInteger x = Word36 . mod36 $ x

instance Real Word36 where
  toRational (Word36 x) = toRational x

instance Enum Word36 where
  toEnum i = Word36 . fromInteger . fromIntegral $ i
  fromEnum (Word36 i) = fromIntegral i

instance Integral Word36 where
  toInteger (Word36 x) = x
  quotRem (Word36 x) (Word36 0) = (max36, word36 x)
  quotRem (Word36 x) (Word36 y) = let (q, r) = quotRem x y in (Word36 q, Word36 r)

instance Uniform Word36 where
  uniformM g = word36 <$> uniformRM (0, fromIntegral max36) g

instance UniformRange Word36 where
  uniformRM (a, b) g = word36 <$> uniformRM (fromIntegral a, fromIntegral b) g

instance Random Word36
