{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import qualified System.Mem as Sys
import Text.Printf (printf)
import Asterius.Types (JSString(..), toJSString)
import Control.Monad (when)
import qualified Screeps.Game as Game

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
foreign import javascript "Game.cpu.getHeapStatistics().used_heap_size" used_heap_size :: IO Int
foreign import javascript "Game.cpu.getHeapStatistics().heap_size_limit" heap_size_limit :: IO Int

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

performGC :: IO ()
performGC = do
  uhs_before <- used_heap_size
  Sys.performGC -- * haskell's garbage collection
  uhs_after <- used_heap_size
  hlim <- heap_size_limit
  console_log . toJSString
    $ printf
      "garbage collected: %d bytes cleared; %.2f%% total used"
      (uhs_before - uhs_after)
      (100 * fromIntegral uhs_after / fromIntegral hlim :: Float)

main :: IO ()
main = do
  t <- Game.time
  when (t `mod` 16 == 0) performGC
  let fibIndex = t `mod` 64
  console_log
    $ "fib "
    `js_concat_str` (toJSString $ show $ fibIndex + 1)
    `js_concat_str` " = "
    `js_concat_str` (toJSString . show $ fibs !! fibIndex)
