{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Text.Printf (printf)
import Asterius.Types (JSString(..), toJSString)
import Control.Monad (when)
import qualified Screeps.Game as Game
import qualified Screeps.Game.CPU as Game.CPU

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "console.log($1)" console_log :: JSString -> IO ()

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

printSystemStats :: IO ()
printSystemStats = do
  cpu_used <- Game.CPU.getUsed
  maybe_heap_stats <- Game.CPU.getHeapStatistics
  let
    memory_used :: Double =
      maybe
        0
        (\x -> 100 * fromIntegral (Game.CPU.used_heap_size x) / fromIntegral (Game.CPU.heap_size_limit x))
        maybe_heap_stats
  console_log . toJSString $ printf "system stats: %.2f cpu used; %.2f%% total memory used;" cpu_used memory_used

main :: IO ()
main = do
  t <- Game.time
  let fib_index = t `mod` 64
  console_log
    $ "fib "
    `js_concat_str` (toJSString $ show $ fib_index + 1)
    `js_concat_str` " = "
    `js_concat_str` (toJSString . show $ fibs !! fib_index)
  when (t `mod` 8 == 0) printSystemStats
