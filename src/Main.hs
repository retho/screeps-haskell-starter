{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import System.Mem (performGC)
import Asterius.Types (JSString(..))
import Control.Monad (when)
import qualified Screeps.Game as Game

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
foreign import javascript "console.log($1)" print_int :: Int -> IO ()

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = do
  t <- Game.time
  print_int $ fibs !! (t `mod` 32)
  when (t `mod` 32 == 11) $ do
    console_log "GC performing"
    performGC -- * haskell's garbage collection
