{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Structures.StructureController
  ( module OwnedStructure
  , StructureController(..)
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Objects.RoomObject
import Screeps.Objects.Structure
import Screeps.Objects.OwnedStructure as OwnedStructure

newtype StructureController = StructureController OwnedStructure deriving (JSRef, JSShow)
instance HasRoomPosition StructureController
instance IsRoomObject StructureController where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_this . toJSRef
instance HasScreepsId StructureController
instance Attackable StructureController
instance NotifyWhenAttacked StructureController
instance IsStructure StructureController where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_this . toJSRef
instance HasOwner StructureController
instance IsOwnedStructure StructureController where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_this . toJSRef


foreign import javascript "$1 instanceof StructureController ? $1 : null" maybe_this :: JSVal -> JSVal
