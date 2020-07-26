{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Structure.StructureSpawn
  ( module OwnedStructure
  , StructureSpawn(..)
  , store
  , spawnCreep
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Objects.Store
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject
import Screeps.Objects.Structure
import Screeps.Objects.OwnedStructure as OwnedStructure

newtype StructureSpawn = StructureSpawn OwnedStructure deriving (JSRef, JSShow)
instance HasRoomPosition StructureSpawn
instance IsRoomObject StructureSpawn where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_spawn . toJSRef
instance HasScreepsId StructureSpawn
instance Attackable StructureSpawn
instance NotifyWhenAttacked StructureSpawn
instance IsStructure StructureSpawn where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_spawn . toJSRef
instance HasOwner StructureSpawn
instance IsOwnedStructure StructureSpawn where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_spawn . toJSRef
instance HasName StructureSpawn
instance HasStore StructureSpawn

spawnCreep :: StructureSpawn -> [BodyPart] -> JSString -> IO ReturnCode
spawnCreep spawn body creep_name = spawn_creep spawn (toJSRef body) creep_name


foreign import javascript "$1 instanceof StructureSpawn ? $1 : null" maybe_spawn :: JSVal -> JSVal
foreign import javascript "$1.spawnCreep($2, $3)" spawn_creep :: StructureSpawn -> JSVal -> JSString -> IO ReturnCode
