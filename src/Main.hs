{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE OverloadedStrings #-}

import System.Mem (performGC)
import Asterius.Types (JSString(..))
import Control.Monad (when)
import qualified Screeps.Game as Game

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
foreign import javascript "console.log($1)" print_int :: Int -> IO ()

fib :: Int -> Int
fib n = go 0 1 0
  where
    go !acc0 acc1 i
      | i == n = acc0
      | otherwise = go acc1 (acc0 + acc1) (i + 1)

main :: IO ()
main = do
  t <- Game.time
  print_int $ fib $ t `mod` 32
  when (t `mod` 32 == 11) $ do
    console_log "GC performing"
    performGC -- * haskell's garbage collection
