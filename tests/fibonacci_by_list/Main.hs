{-# OPTIONS_GHC -Wall #-}

import Data.Traversable (for)

foreign import javascript "console.log($1)" print_int :: Int -> IO ()

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = do
  _ <- for [0..31] $ \ix -> print_int $ fibs !! ix
  pure ()
