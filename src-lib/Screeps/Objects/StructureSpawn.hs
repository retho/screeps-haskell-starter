{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.StructureSpawn
  ( module OwnedStructure
  , StructureSpawn()
  , spawnCreep
  ) where

import Screeps.Utils
import Screeps.Internal

import Screeps.Objects.RoomObject
import Screeps.Objects.Structure
import Screeps.Objects.OwnedStructure as OwnedStructure


spawnCreep :: StructureSpawn -> [BodyPart] -> JSString -> IO ReturnCode
spawnCreep spawn body creep_name = spawn_creep spawn (toJSRef body) creep_name


foreign import javascript "$1.spawnCreep($2, $3)" spawn_creep :: StructureSpawn -> JSVal -> JSString -> IO ReturnCode
