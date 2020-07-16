{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Prelude hiding (break)
import Screeps.Prelude
import Text.Printf (printf)

import Control.Monad (when)
import Data.Foldable (for_)
import qualified Screeps.Game as Game
import qualified Screeps.Game.CPU as Game.CPU
import qualified Screeps.Objects.StructureSpawn as Spawn
import qualified Screeps.Constants.BodyPart as BodyPart
import qualified Screeps.Constants.Resource as Resource
import qualified Screeps.Constants.ReturnCode as ReturnCode

import Logging as Logging

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
  Game.CPU.getUsed >>= \cpu -> debug $ "loop starting! cpu: " <> showjs cpu
  printSystemStats
  setupLogging Logging.Info
  game_spawns <- Game.spawns
  game_creeps <- Game.creeps

  for_ (values game_spawns) $ \spawn -> do
    debug $ "running spawn " <> Spawn.name spawn
    let body = [BodyPart.move, BodyPart.move, BodyPart.carry, BodyPart.work]
    when (storeUsedCapacity spawn (pure Resource.energy) >= sum (map BodyPart.cost body)) $ do
      -- * create a unique name, spawn.
      name_base <- Game.time
      let
        loop :: (a -> Bool) -> [IO a] -> IO a
        loop _ [] = undefined
        loop break (x:xs) = x >>= \r -> if break r then pure r else loop break xs
      res <- loop (/= ReturnCode.err_name_exists) $ flip map [0..] $ \(additional :: Int) -> do
        let name = showjs name_base <> "-" <> showjs additional
        Spawn.spawnCreep spawn body name
      when (res /= ReturnCode.ok) $ do
        warn $ "couldn't spawn: " <> showjs res

  info $ "creeps: " <> showjs (values game_creeps)
  Game.CPU.getUsed >>= \cpu -> info $ "done! cpu: " <> showjs cpu
