{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.OwnedStructure
  ( module Structure
  , OwnedStructure(..)
  , IsOwnedStructure(..)
  ) where

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject
import Screeps.Objects.Structure as Structure

newtype OwnedStructure = OwnedStructure Structure deriving (JSRef, JSShow)
instance Attackable OwnedStructure
instance HasScreepsId OwnedStructure
instance HasRoomPosition OwnedStructure
instance HasOwner OwnedStructure
instance IsRoomObject OwnedStructure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_owned_structure . toJSRef
instance IsStructure OwnedStructure where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_owned_structure . toJSRef
instance IsOwnedStructure OwnedStructure where
  asOwnedStructure = id
  fromOwnedStruture = pure

class IsStructure a => IsOwnedStructure a where
  asOwnedStructure :: a -> OwnedStructure
  fromOwnedStruture :: OwnedStructure -> Maybe a

foreign import javascript "$1 instanceof OwnedStructure ? $1 : null" maybe_owned_structure :: JSVal -> JSVal
