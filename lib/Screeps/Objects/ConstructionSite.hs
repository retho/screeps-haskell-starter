{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.ConstructionSite
  ( module RoomObject
  , ConstructionSite(..)
  , progress
  , progressTotal
  , structureType
  , remove
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype ConstructionSite = ConstructionSite RoomObject deriving (JSRef, JSShow)
instance HasRoomPosition ConstructionSite
instance IsRoomObject ConstructionSite where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_construction_site . toJSRef
instance HasScreepsId ConstructionSite
instance HasOwner ConstructionSite


foreign import javascript "$1.progress" progress :: ConstructionSite -> Int
foreign import javascript "$1.progressTotal" progressTotal :: ConstructionSite -> Int
foreign import javascript "$1.structureType" structureType :: ConstructionSite -> StructureType

foreign import javascript "$1.remove()" remove :: ConstructionSite -> IO ()

-- *

foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_construction_site :: JSVal -> JSVal
