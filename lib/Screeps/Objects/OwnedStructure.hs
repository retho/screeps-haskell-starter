{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.OwnedStructure
  ( module Structure
  , OwnedStructure(..)
  , IsOwnedStructure(..)
  ) where

import Screeps.Utils

import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject
import Screeps.Objects.Structure as Structure

newtype OwnedStructure = OwnedStructure Structure deriving (JSRef, JSShow)
instance HasRoomPosition OwnedStructure
instance IsRoomObject OwnedStructure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_owned_structure . toJSRef
instance HasScreepsId OwnedStructure
instance Attackable OwnedStructure
instance NotifyWhenAttacked OwnedStructure
instance IsStructure OwnedStructure where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_owned_structure . toJSRef
instance HasOwner OwnedStructure
instance IsOwnedStructure OwnedStructure where
  asOwnedStructure = id
  fromOwnedStruture = pure

class (IsStructure a, HasOwner a) => IsOwnedStructure a where
  asOwnedStructure :: a -> OwnedStructure
  fromOwnedStruture :: OwnedStructure -> Maybe a

foreign import javascript "$1 instanceof OwnedStructure ? $1 : null" maybe_owned_structure :: JSVal -> JSVal
