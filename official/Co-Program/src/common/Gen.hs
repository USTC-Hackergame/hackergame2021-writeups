{- Generate (balanced) expressions of a specified depth -}
module Gen where

import           Control.Monad.Random.Class
import qualified Language as L

-- |生成所有指定深度的表达式。
exprsWithDepth :: [String] -> Int -> [L.Expr]
exprsWithDepth vars 0 = fmap L.Var vars
exprsWithDepth vars n = do
  let subs = exprsWithDepth vars (n-1)
  let unary  = do op1 <- L.unaryOps
                  sub <- subs
                  return (op1 sub)
  let binary = do op2 <- L.binaryOps
                  sub1 <- subs
                  sub2 <- subs
                  return (sub1 `op2` sub2)
  unary ++ binary

-- |随机生成一个指定深度的表达式。
-- prob: 选择一元子表达式的概率。
randomExprWithDepth' :: MonadRandom m => Double -> [String] -> Int -> m L.Expr
randomExprWithDepth' _ vars 0    = fmap L.Var (choose vars)
randomExprWithDepth' prob vars n = do
  let unary = do
        op  <- choose L.unaryOps
        sub <- randomExprWithDepth' prob vars (n-1)
        return (op sub)
      binary = do
        op   <- choose L.binaryOps
        sub1 <- randomExprWithDepth' prob vars (n-1)
        sub2 <- randomExprWithDepth' prob vars (n-1)
        return (sub1 `op` sub2)
  branch prob unary binary

-- |默认概率=0.3
randomExprWithDepth :: MonadRandom m => [String] -> Int -> m L.Expr
randomExprWithDepth = randomExprWithDepth' 0.3

-- |随机生成一个函数body（带 if 的, 自由变元 x, y 的，最终类型为 int 的表达式）
randomFuncWithDepth' :: MonadRandom m => Double -> Double -> Int -> m L.Expr
randomFuncWithDepth' _ _ 0 = choose [L.Var "x", L.Var "y"]
randomFuncWithDepth' unaryProb ifProb n = do
  let genSub = randomFuncWithDepth' unaryProb ifProb (n-1)
      unaryInt = do
        op <- choose L.unaryOps
        sub <- genSub
        return (op sub)
      binaryInt = do
        op <- choose L.binaryOps
        sub1 <- genSub
        sub2 <- genSub
        return (sub1 `op` sub2)
      ifInt = do
        c <- boolExpr (n-1)
        sub1 <- genSub
        sub2 <- genSub
        return (L.If c sub1 sub2)
      boolExpr 0 = choose [L.Bool True, L.Bool False]
      boolExpr m =  do
        let cmp = do
              a <- genSub
              b <- genSub
              op <- choose [L.Eq, L.Le]
              return $ a `op` b
            nest2 = do
              a <- boolExpr (m-1)
              b <- boolExpr (m-1)
              op <- choose [L.And, L.Or]
              return $ a `op` b
            nest1 = do
              op <- choose [L.Not]
              a <- boolExpr (m-1)
              return $ op a
        branch3 (1/3) (1/3) cmp nest2 nest1 -- 随便指定一些概率。。。
  branch3 unaryProb ifProb unaryInt ifInt binaryInt

randomFuncWithDepth :: MonadRandom m => Int -> m L.Expr
randomFuncWithDepth = randomFuncWithDepth' 0.2 0.3

choose :: MonadRandom m => [a] -> m a
choose []  = error "Cannot choose from an empty list!"
choose [x] = return x
choose xs  = do
  i <- getRandomR (0, (length xs)-1)
  return (xs !! i)
{-# INLINABLE choose #-}

branch :: MonadRandom m => Double -> m a -> m a -> m a
branch prob a b = do
  x <- getRandomR (0.0, 1.0)
  if x < prob then a else b
{-# INLINABLE branch #-}

branch3 :: MonadRandom m => Double -> Double -> m a -> m a -> m a -> m a
branch3 prob1 prob2 a b c = do
  let p1 = prob1
      p2 = prob2 / ((1 - prob1 - prob2) + prob2)
  branch p1 a (branch p2 b c)
