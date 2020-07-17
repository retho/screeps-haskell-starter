{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Creep
  ( Creep(..)
  ) where

import Screeps.Core

import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject

newtype Creep = Creep RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance IsRoomObject Creep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_creep . toJSRef



foreign import javascript "$1 instanceof Creep ? $1 : null" maybe_creep :: JSVal -> JSVal
