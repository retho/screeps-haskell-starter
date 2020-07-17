{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Creep
  ( Creep(..)
  , name
  ) where

import Screeps.Core
import Screeps.Memory
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject

newtype Creep = Creep RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance HasMemory Creep where memory x = Memory ["creeps", name x]
instance IsRoomObject Creep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_creep . toJSRef

foreign import javascript "$1.name" name :: Creep -> JSString



foreign import javascript "$1 instanceof Creep ? $1 : null" maybe_creep :: JSVal -> JSVal
