{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Structure
  ( module RoomObject
  , Structure(..)
  , IsStructure(..)
  , structureType
  , destroy
  , isActive
  ) where

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject
import Screeps.Constants.StructureType
import Screeps.Constants.ReturnCode

newtype Structure = Structure RoomObject deriving (JSRef, JSShow)
instance HasRoomPosition Structure
instance HasScreepsId Structure
instance Attackable Structure
instance NotifyWhenAttacked Structure
instance IsRoomObject Structure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure . toJSRef
instance IsStructure Structure where
  asStructure = id
  fromStructure = pure

class (IsRoomObject a, Attackable a, HasScreepsId a, NotifyWhenAttacked a) => IsStructure a where
  asStructure :: a -> Structure
  fromStructure :: Structure -> Maybe a

structureType :: IsStructure a => a -> StructureType
destroy :: IsStructure a => a -> IO ReturnCode
isActive :: IsStructure a => a -> Bool


-- *
structureType = js_structureType . asStructure
destroy = js_destroy . asStructure
isActive = js_isActive . asStructure

foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_structure :: JSVal -> JSVal

foreign import javascript "$1.structureType" js_structureType :: Structure -> StructureType
foreign import javascript "$1.destroy()" js_destroy :: Structure -> IO ReturnCode
foreign import javascript "$1.isActive()" js_isActive :: Structure -> Bool
