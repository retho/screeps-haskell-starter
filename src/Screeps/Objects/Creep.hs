{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Creep
  ( module RoomObject
  , Creep(..)
  , name
  , spawning
  , harvest
  , moveTo
  , upgradeController
  ) where

import Screeps.Core
import Screeps.Memory
import Screeps.Objects.Classes
import Screeps.Objects.Store
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject
import Screeps.Objects.Structure.StructureController
import Screeps.Constants.ReturnCode

newtype Creep = Creep RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance HasMemory Creep where memory x = Memory ["creeps", name x]
instance HasStore Creep where store = defaultStore
instance IsRoomObject Creep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_creep . toJSRef

foreign import javascript "$1.name" name :: Creep -> JSString
foreign import javascript "$1.spawning" spawning :: Creep -> Bool

harvest :: Harvestable a => Creep -> a -> IO ReturnCode
harvest c = creep_harvest c . asHarvestable

moveTo :: HasRoomPosition a => Creep -> a -> IO ReturnCode
moveTo c = creep_move_to c . pos

upgradeController :: Creep -> StructureController -> IO ReturnCode
upgradeController = creep_upgrade_controller

-- *

foreign import javascript "$1 instanceof Creep ? $1 : null" maybe_creep :: JSVal -> JSVal
foreign import javascript "$1.harvest($2)" creep_harvest :: Creep -> JSVal -> IO ReturnCode
foreign import javascript "$1.moveTo($2)" creep_move_to :: Creep -> RoomPosition -> IO ReturnCode
foreign import javascript "$1.upgradeController($2)" creep_upgrade_controller :: Creep -> StructureController -> IO ReturnCode

