module Screeps.Objects.Structure
  ( module RoomObject
  , Structure()
  , structureType
  , destroy
  , isActive
  ) where

import Screeps.Utils
import Screeps.Internal

import Screeps.Objects.RoomObject as RoomObject


structureType :: IsStructure a => a -> StructureType
destroy :: IsStructure a => a -> IO ReturnCode
isActive :: IsStructure a => a -> Bool


structureType = js_structureType . asStructure
destroy = js_destroy . asStructure
isActive = js_isActive . asStructure

foreign import javascript "$1.structureType" js_structureType :: Structure -> StructureType
foreign import javascript "$1.destroy()" js_destroy :: Structure -> IO ReturnCode
foreign import javascript "$1.isActive()" js_isActive :: Structure -> Bool
