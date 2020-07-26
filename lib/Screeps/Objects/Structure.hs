{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Structure
  ( module RoomObject
  , Structure(..)
  , IsStructure(..)
  ) where

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype Structure = Structure RoomObject deriving (JSRef, JSShow)
instance HasRoomPosition Structure
instance HasScreepsId Structure
instance Attackable Structure
instance IsRoomObject Structure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure . toJSRef
instance IsStructure Structure where
  asStructure = id
  fromStructure = pure

class IsRoomObject a => IsStructure a where
  asStructure :: a -> Structure
  fromStructure :: Structure -> Maybe a


foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_structure :: JSVal -> JSVal
