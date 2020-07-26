{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.PowerCreep
  ( module RoomObject
  , module SharedCreep
  , PowerCreep(..)
  ) where

import Screeps.Core
import Screeps.Memory
import Screeps.Objects.Classes
import Screeps.Objects.SharedCreep as SharedCreep
import Screeps.Objects.Store
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype PowerCreep = PowerCreep SharedCreep deriving (JSRef, JSShow)
instance HasScreepsId PowerCreep
instance HasMemory PowerCreep where memory x = Memory ["creeps", name x]
instance HasStore PowerCreep
instance HasRoomPosition PowerCreep
instance HasName PowerCreep
instance HasOwner PowerCreep
instance Attackable PowerCreep
instance Transferable PowerCreep
instance Withdrawable PowerCreep
instance NotifyWhenAttacked PowerCreep
instance IsRoomObject PowerCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_power_creep . toJSRef
instance IsSharedCreep PowerCreep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_power_creep . toJSRef


-- *
foreign import javascript "$1 instanceof PowerCreep ? $1 : null" maybe_power_creep :: JSVal -> JSVal
