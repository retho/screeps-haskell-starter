{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import qualified System.Mem as Sys
import Text.Printf (printf)
import Asterius.Types (JSString(..), toJSString)
import Control.Monad (when)
import qualified Screeps.Game as Game

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
foreign import javascript "Game.cpu.getUsed()" cpu_used :: IO Float
foreign import javascript "Game.cpu.getHeapStatistics().used_heap_size" used_heap_size :: IO Int
foreign import javascript "Game.cpu.getHeapStatistics().heap_size_limit" heap_size_limit :: IO Int

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

printSystemStats :: IO ()
printSystemStats = do
  uhs <- used_heap_size
  hlim <- heap_size_limit
  cpu <- cpu_used
  console_log . toJSString
    $ printf
      "stats: %.2f cpu used; %.2f%% total memory used;"
      cpu
      (100 * fromIntegral uhs / fromIntegral hlim :: Float)

main :: IO ()
main = do
  t <- Game.time
  let fibIndex = t `mod` 64
  console_log
    $ "fib "
    `js_concat_str` (toJSString $ show $ fibIndex + 1)
    `js_concat_str` " = "
    `js_concat_str` (toJSString . show $ fibs !! fibIndex)
  when (t `mod` 4 == 0) printSystemStats

