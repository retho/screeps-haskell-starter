{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Game
  ( time
  , spawns
  , creeps
  ) where

import Screeps.Core
import Screeps.Objects.StructureSpawn (StructureSpawn)
import Screeps.Objects.Creep (Creep)

foreign import javascript "Game.time" raw_time :: IO Int
foreign import javascript "Game.spawns" raw_spawns :: IO (JSHashMap JSString StructureSpawn)
foreign import javascript "Game.creeps" raw_creeps :: IO (JSHashMap JSString Creep)

time :: IO Int
time = raw_time

spawns :: IO (JSHashMap JSString StructureSpawn)
spawns = raw_spawns

creeps :: IO (JSHashMap JSString Creep)
creeps = raw_creeps
