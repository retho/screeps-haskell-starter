{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Internal.Objects
  ( IsRoomObject(..)
  , IsSharedCreep(..)
  , IsStructure(..)
  , IsOwnedStructure(..)
  -- *
  , RoomObject(..)
  , ConstructionSite(..)
  , SharedCreep(..)
  , Creep(..)
  , PowerCreep(..)
  , Resource(..)
  , Source(..)
  , Structure(..)
  , OwnedStructure(..)
  ) where

import Screeps.Utils
import Screeps.Internal.Classes


newtype RoomObject = RoomObject JSObject deriving (JSRef, JSShow)
instance HasRoomPosition RoomObject
instance IsRoomObject RoomObject where
  asRoomObject = id
  fromRoomObject = pure
class HasRoomPosition a => IsRoomObject a where
  asRoomObject :: a -> RoomObject
  fromRoomObject :: RoomObject -> Maybe a


newtype ConstructionSite = ConstructionSite RoomObject deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_construction_site :: JSVal -> JSVal
instance HasRoomPosition ConstructionSite
instance IsRoomObject ConstructionSite where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_construction_site . toJSRef
instance HasScreepsId ConstructionSite
instance HasOwner ConstructionSite


newtype SharedCreep = SharedCreep RoomObject deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Screep || $1 instanceof PowerScreep ? $1 : null" maybe_shared_creep :: JSVal -> JSVal
instance HasRoomPosition SharedCreep
instance IsRoomObject SharedCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_shared_creep . toJSRef
instance HasScreepsId SharedCreep
instance HasStore SharedCreep
instance HasName SharedCreep
instance HasOwner SharedCreep
instance Attackable SharedCreep
instance Transferable SharedCreep
instance Withdrawable SharedCreep
instance NotifyWhenAttacked SharedCreep
instance IsSharedCreep SharedCreep where
  asSharedCreep = id
  fromSharedCreep = pure
class (IsRoomObject a, HasScreepsId a, HasStore a, HasName a, HasOwner a, Attackable a, Transferable a, Withdrawable a, NotifyWhenAttacked a) => IsSharedCreep a where
  asSharedCreep :: a -> SharedCreep
  fromSharedCreep :: SharedCreep -> Maybe a


newtype Creep = Creep SharedCreep deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Creep ? $1 : null" maybe_creep :: JSVal -> JSVal
instance HasRoomPosition Creep
instance IsRoomObject Creep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_creep . toJSRef
instance HasScreepsId Creep
instance HasStore Creep
instance HasName Creep
instance HasOwner Creep
instance Attackable Creep
instance Transferable Creep
instance Withdrawable Creep
instance NotifyWhenAttacked Creep
instance IsSharedCreep Creep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_creep . toJSRef


newtype PowerCreep = PowerCreep SharedCreep deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof PowerCreep ? $1 : null" maybe_power_creep :: JSVal -> JSVal
instance HasRoomPosition PowerCreep
instance IsRoomObject PowerCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_power_creep . toJSRef
instance HasScreepsId PowerCreep
instance HasStore PowerCreep
instance HasName PowerCreep
instance HasOwner PowerCreep
instance Attackable PowerCreep
instance Transferable PowerCreep
instance Withdrawable PowerCreep
instance NotifyWhenAttacked PowerCreep
instance IsSharedCreep PowerCreep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_power_creep . toJSRef


newtype Resource = Resource RoomObject deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Resource ? $1 : null" maybe_resource :: JSVal -> JSVal
instance HasRoomPosition Resource
instance IsRoomObject Resource where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_resource . toJSRef
instance HasScreepsId Resource


newtype Source = Source RoomObject deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Source ? $1 : null" maybe_source :: JSVal -> JSVal
instance HasRoomPosition Source
instance IsRoomObject Source where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_source . toJSRef
instance Harvestable Source


newtype Structure = Structure RoomObject deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_structure :: JSVal -> JSVal
instance HasRoomPosition Structure
instance IsRoomObject Structure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure . toJSRef
instance HasScreepsId Structure
instance Attackable Structure
instance NotifyWhenAttacked Structure
instance IsStructure Structure where
  asStructure = id
  fromStructure = pure
class (IsRoomObject a, HasScreepsId a, Attackable a, NotifyWhenAttacked a) => IsStructure a where
  asStructure :: a -> Structure
  fromStructure :: Structure -> Maybe a


newtype OwnedStructure = OwnedStructure Structure deriving (JSRef, JSShow)
foreign import javascript "$1 instanceof OwnedStructure ? $1 : null" maybe_owned_structure :: JSVal -> JSVal
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
