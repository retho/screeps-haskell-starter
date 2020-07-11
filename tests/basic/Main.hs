{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import System.Mem (performGC)
import Asterius.Types (JSString(..))
import Control.Monad (when)

foreign import javascript "Game.time" game_time :: IO Int
foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
foreign import javascript "console.log($1)" print_int :: Int -> IO ()

main :: IO ()
main = do
  t <- game_time
  print_int t
  when (t `mod` 32 == 11) $ do
    console_log "manual GC performing"
    performGC -- * haskell's garbage collection
