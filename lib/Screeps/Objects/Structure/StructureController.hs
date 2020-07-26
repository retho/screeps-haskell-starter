{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Structure.StructureController
  ( module OwnedStructure
  , StructureController(..)
  , name
  , spawnCreep
  ) where

import Screeps.Core

import Screeps.Objects.Classes
import Screeps.Objects.Store
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject
import Screeps.Objects.Structure
import Screeps.Objects.OwnedStructure as OwnedStructure
import Screeps.Constants.BodyPart
import Screeps.Constants.ReturnCode

newtype StructureController = StructureController OwnedStructure deriving (JSRef, JSShow)
instance Attackable StructureController
instance HasOwner StructureController
instance HasScreepsId StructureController
instance HasRoomPosition StructureController
instance HasStore StructureController
instance HasName StructureController
instance IsRoomObject StructureController where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_spawn . toJSRef
instance IsStructure StructureController where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_spawn . toJSRef
instance IsOwnedStructure StructureController where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_spawn . toJSRef


spawnCreep :: StructureController -> [BodyPart] -> JSString -> IO ReturnCode
spawnCreep spawn body creep_name = spawn_creep spawn (toJSRef body) creep_name


foreign import javascript "$1 instanceof StructureController ? $1 : null" maybe_spawn :: JSVal -> JSVal
foreign import javascript "$1.spawnCreep($2, $3)" spawn_creep :: StructureController -> JSVal -> JSString -> IO ReturnCode
