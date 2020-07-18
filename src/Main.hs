{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Prelude hiding (break)
import Screeps.Prelude

import Text.Printf (printf)
import Control.Monad (when)
import Data.Foldable (for_)

import qualified Screeps.Game as Game
import qualified Screeps.Memory as Mem
import qualified Screeps.Game.CPU as Game.CPU
import qualified Screeps.Objects.Structure.StructureSpawn as Spawn
import qualified Screeps.Constants.BodyPart as BodyPart
import qualified Screeps.Constants.ResourceType as ResourceType
import qualified Screeps.Constants.ReturnCode as ReturnCode

import Logging as Logging


main :: IO ()
main = do
  Game.CPU.getUsed >>= \cpu -> debug $ "loop starting! cpu: " <> showjs cpu
  setupLogging Logging.Info

  game_spawns <- Game.spawns
  for_ (values game_spawns) $ \spawn -> do
    debug $ "running spawn " <> Spawn.name spawn
    let body = [BodyPart.move, BodyPart.move, BodyPart.carry, BodyPart.work]
    when (storeUsedCapacity spawn (pure ResourceType.energy) >= sum (map BodyPart.cost body)) $ do
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

  game_creeps <- Game.creeps
  info $ "creeps: " <> showjs (values game_creeps)

  time <- Game.time
  when (time `mod` 32 == 3) $ do
    info "running memory cleanup"
    cleanup_memory

  Game.CPU.getUsed >>= \cpu -> info . toJSString $ printf "done! cpu: %.2f" cpu


cleanup_memory :: IO ()
cleanup_memory = do
  alive_creeps :: [JSString] <- Game.creeps >>= pure . keys
  let creeps_mem = Mem.path Mem.root ["creeps"]
  creeps_memory_keys <- Mem.keys creeps_mem >>= pure . maybe [] id

  for_ creeps_memory_keys $ \mem_name -> do
    when (mem_name `notElem` alive_creeps) $ do
      debug $ "cleaning up creep memory of dead creep " <> mem_name
      Mem.del creeps_mem mem_name
