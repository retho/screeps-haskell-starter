{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Screeps.Prelude
import Text.Printf (printf)

import qualified Screeps.Game as Game
import qualified Screeps.Game.CPU as Game.CPU

import Logging as Logging

fibs :: [Int]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

printSystemStats :: IO ()
printSystemStats = do
  maybe_heap_stats <- Game.CPU.getHeapStatistics
  let
    memory_used :: Double =
      maybe
        0
        (\x -> 100 * fromIntegral (Game.CPU.used_heap_size x) / fromIntegral (Game.CPU.heap_size_limit x))
        maybe_heap_stats
  debug $ toJSString $ printf "system stats: %.2f%% total memory used" memory_used

main :: IO ()
main = do
  Game.CPU.getUsed >>= \cpu -> debug $ "loop starting! cpu: " <> jsshow cpu
  printSystemStats
  setupLogging Logging.Info
  game_spawns <- Game.spawns
  info $ "spawns: " <> jsshow (values game_spawns)
  game_creeps <- Game.creeps
  info $ "creeps: " <> jsshow (values game_creeps)
  t <- Game.time
  let fib_index = t `mod` 64
  info $ "fib " <> jsshow (fib_index + 1) <> " = " <> jsshow (fibs !! fib_index)
  Game.CPU.getUsed >>= \cpu -> info $ "done! cpu: " <> jsshow cpu
