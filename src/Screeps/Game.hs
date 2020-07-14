{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Game
  ( time
  , spawns
  ) where

import Screeps.Prelude
import Screeps.Objects.StructureSpawn (StructureSpawn)

foreign import javascript "Game.time" raw_time :: IO Int
foreign import javascript "Game.spawns" raw_spawns :: IO (JSObject StructureSpawn)

time :: IO Int
time = raw_time

spawns :: IO (JSObject StructureSpawn)
spawns = raw_spawns
