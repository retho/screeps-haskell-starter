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

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Constants.StructureType
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype ConstructionSite = ConstructionSite RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance HasScreepsId ConstructionSite where sid = defaultSid
instance IsRoomObject ConstructionSite where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_construction_site . toJSRef
instance HasOwner ConstructionSite where
  my = defaultMy
  owner = defaultOwner


progress :: ConstructionSite -> Int
progressTotal :: ConstructionSite -> Int
structureType :: ConstructionSite -> StructureType
remove :: ConstructionSite -> IO ()

-- *

progress = js_progress . coerce
progressTotal = js_progress_total . coerce
remove = js_remove . coerce
structureType = js_structure_type . coerce

foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_construction_site :: JSVal -> JSVal
foreign import javascript "$1.progress" js_progress :: JSVal -> Int
foreign import javascript "$1.progressTotal" js_progress_total :: JSVal -> Int
foreign import javascript "$1.remove()" js_remove :: JSVal -> IO ()
foreign import javascript "$1.structureType" js_structure_type :: JSVal -> StructureType
