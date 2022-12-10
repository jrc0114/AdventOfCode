-- | Common utility functions
module Util.Util
    ( module Util.Util
    , module Control.Applicative
    , module Linear.V2) where

import Control.Applicative
import Linear.V2

-- | F# Style forward-application
(|>) :: a -> (a -> b) -> b
x |> f = f x

-- | Forward composition, equivalent Control.Arrow.>>>
(.>) :: (a -> b) -> (b -> c) -> (a -> c)
f .> g = g . f

infixr 1 .>, |>

(&&&+) :: (a -> b -> c) -> (a -> b -> d) -> a -> b -> (c, d)
f &&&+ g = \a b -> (f a b, g a b)

-- Using this over V2 for named fields >:(
data Pair a = P {x :: a, y :: a} deriving (Eq, Ord, Show)
instance Functor Pair where
    fmap f P{..} = P (f x) (f y)
instance Applicative Pair where
    pure a = P a a
    P f g <*> P{..} = P (f x) (g y)
instance Monad Pair where
    P{..} >>= f = P x' y' where
        P x' _ = f x
        P _ y' = f y
instance Num a => Num (Pair a) where
    (+) = liftA2 (+)
    (-) = liftA2 (-)
    (*) = liftA2 (*)
    abs = fmap abs
    signum = fmap signum
    fromInteger = pure . fromInteger

chunks n [] = []
chunks n xs = case splitAt n xs of (a, as) -> a : chunks n as