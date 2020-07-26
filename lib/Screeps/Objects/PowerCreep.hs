{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.PowerCreep
  ( module RoomObject
  , module SharedCreep
  , PowerCreep(..)
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Memory
import Screeps.Objects.SharedCreep as SharedCreep
import Screeps.Objects.Store
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype PowerCreep = PowerCreep SharedCreep deriving (JSRef, JSShow)
instance HasRoomPosition PowerCreep
instance IsRoomObject PowerCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_power_creep . toJSRef
instance HasScreepsId PowerCreep
instance HasStore PowerCreep
instance HasName PowerCreep
instance HasOwner PowerCreep
instance Attackable PowerCreep
instance Transferable PowerCreep
instance Withdrawable PowerCreep
instance NotifyWhenAttacked PowerCreep
instance IsSharedCreep PowerCreep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_power_creep . toJSRef
instance HasMemory PowerCreep where memory x = Memory ["powerCreeps", name x]


-- *
foreign import javascript "$1 instanceof PowerCreep ? $1 : null" maybe_power_creep :: JSVal -> JSVal
