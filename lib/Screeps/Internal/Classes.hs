{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Internal.Classes
  ( HasScreepsId(..)
  , Harvestable(..)
  , HasOwner(..)
  , Attackable(..)
  , hits
  , hitsMax
  , HasName(..)
  , Transferable(..)
  , Withdrawable(..)
  , NotifyWhenAttacked(..)
  , HasRoomPosition(..)
  , HasStore(..)
  -- *
  , IsRoomObject(..)
  , IsSharedCreep(..)
  , IsStructure(..)
  , IsOwnedStructure(..)
  ) where

import Screeps.Utils
import Screeps.Internal.Constants
import Screeps.Internal.Objects


class JSRef a => HasScreepsId a where
  sid :: a -> ScreepsId a
  sid = coerce . default_sid . toJSRef

class JSRef a => Harvestable a where
  asHarvestable :: a -> JSVal
  asHarvestable = toJSRef

class JSRef a => HasOwner a where
  my :: a -> Bool
  owner :: a -> User
  my = def_my . toJSRef
  owner = def_owner . toJSRef

class JSRef a => Attackable a where
  asAttackable :: a -> JSVal
  asAttackable = toJSRef
hits :: Attackable a => a -> Int
hitsMax :: Attackable a => a -> Int
hits = def_hits . asAttackable
hitsMax = def_hits_max . asAttackable

class JSRef a => HasName a where
  name :: a -> JSString
  name = js_name . toJSRef

class JSRef a => Transferable a where
  asTransferable :: a -> JSVal
  asTransferable = toJSRef

class JSRef a => Withdrawable a where
  asWithdrawable :: a -> JSVal
  asWithdrawable = toJSRef

class JSRef a => NotifyWhenAttacked a where
  notifyWhenAttacked :: a -> Bool -> IO ReturnCode
  notifyWhenAttacked self enabled = js_notifyWhenAttacked (toJSRef self) enabled

class JSRef a => HasRoomPosition a where
  pos :: a -> RoomPosition
  pos = js_pos . toJSRef

class JSRef a => HasStore a where
  store :: a -> Store
  store = default_store . toJSRef

class HasRoomPosition a => IsRoomObject a where
  asRoomObject :: a -> RoomObject
  fromRoomObject :: RoomObject -> Maybe a

class (IsRoomObject a, HasScreepsId a, HasStore a, HasName a, HasOwner a, Attackable a, Transferable a, Withdrawable a, NotifyWhenAttacked a) => IsSharedCreep a where
  asSharedCreep :: a -> SharedCreep
  fromSharedCreep :: SharedCreep -> Maybe a

class (IsRoomObject a, HasScreepsId a, Attackable a, NotifyWhenAttacked a) => IsStructure a where
  asStructure :: a -> Structure
  fromStructure :: Structure -> Maybe a

class (IsStructure a, HasOwner a) => IsOwnedStructure a where
  asOwnedStructure :: a -> OwnedStructure
  fromOwnedStruture :: OwnedStructure -> Maybe a


-- *
instance HasScreepsId ConstructionSite
instance HasScreepsId SharedCreep
instance HasScreepsId Creep
instance HasScreepsId PowerCreep
instance HasScreepsId Resource
instance HasScreepsId Structure
instance HasScreepsId OwnedStructure
instance HasScreepsId StructureController
instance HasScreepsId StructureSpawn


instance HasName Room
instance HasName SharedCreep
instance HasName Creep
instance HasName PowerCreep
instance HasName StructureSpawn


instance HasOwner ConstructionSite
instance HasOwner SharedCreep
instance HasOwner Creep
instance HasOwner PowerCreep
instance HasOwner OwnedStructure
instance HasOwner StructureController
instance HasOwner StructureSpawn


instance HasStore Store where store = id
instance HasStore SharedCreep
instance HasStore Creep
instance HasStore PowerCreep
instance HasStore StructureSpawn


instance Attackable StructureController
instance Attackable SharedCreep
instance Attackable Creep
instance Attackable PowerCreep
instance Attackable Structure
instance Attackable OwnedStructure
instance Attackable StructureSpawn


instance Transferable SharedCreep
instance Transferable Creep
instance Transferable PowerCreep


instance Withdrawable SharedCreep
instance Withdrawable Creep
instance Withdrawable PowerCreep


instance NotifyWhenAttacked StructureController
instance NotifyWhenAttacked SharedCreep
instance NotifyWhenAttacked Creep
instance NotifyWhenAttacked PowerCreep
instance NotifyWhenAttacked Structure
instance NotifyWhenAttacked OwnedStructure
instance NotifyWhenAttacked StructureSpawn


instance Harvestable Source
instance Harvestable Mineral
instance Harvestable Deposit


instance HasRoomPosition RoomPosition where pos = id
instance HasRoomPosition RoomObject
instance HasRoomPosition ConstructionSite
instance HasRoomPosition SharedCreep
instance HasRoomPosition Creep
instance HasRoomPosition PowerCreep
instance HasRoomPosition Resource
instance HasRoomPosition Source
instance HasRoomPosition Deposit
instance HasRoomPosition Flag
instance HasRoomPosition Mineral
instance HasRoomPosition Nuke
instance HasRoomPosition Ruin
instance HasRoomPosition Tombstone
instance HasRoomPosition Structure
instance HasRoomPosition OwnedStructure
instance HasRoomPosition StructureController
instance HasRoomPosition StructureSpawn


instance IsSharedCreep SharedCreep where
  asSharedCreep = id
  fromSharedCreep = pure
instance IsSharedCreep Creep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_creep . toJSRef
instance IsSharedCreep PowerCreep where
  asSharedCreep = coerce
  fromSharedCreep = fromJSRef . maybe_power_creep . toJSRef


instance IsRoomObject RoomObject where
  asRoomObject = id
  fromRoomObject = pure
instance IsRoomObject ConstructionSite where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_construction_site . toJSRef
instance IsRoomObject Creep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_creep . toJSRef
instance IsRoomObject PowerCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_power_creep . toJSRef
instance IsRoomObject Resource where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_resource . toJSRef
instance IsRoomObject Deposit where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_deposit . toJSRef
instance IsRoomObject Flag where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_flag . toJSRef
instance IsRoomObject Mineral where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_mineral . toJSRef
instance IsRoomObject Nuke where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_nuke . toJSRef
instance IsRoomObject Ruin where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_ruin . toJSRef
instance IsRoomObject Tombstone where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_tombstone . toJSRef
instance IsRoomObject Source where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_source . toJSRef
instance IsRoomObject SharedCreep where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_shared_creep . toJSRef
instance IsRoomObject Structure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure . toJSRef
instance IsRoomObject OwnedStructure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_owned_structure . toJSRef
instance IsRoomObject StructureController where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_controller . toJSRef
instance IsRoomObject StructureSpawn where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_spawn . toJSRef


instance IsStructure Structure where
  asStructure = id
  fromStructure = pure
instance IsStructure OwnedStructure where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_owned_structure . toJSRef
instance IsStructure StructureController where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_controller . toJSRef
instance IsStructure StructureSpawn where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_spawn . toJSRef


instance IsOwnedStructure OwnedStructure where
  asOwnedStructure = id
  fromOwnedStruture = pure
instance IsOwnedStructure StructureController where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_controller . toJSRef
instance IsOwnedStructure StructureSpawn where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_spawn . toJSRef


-- *
foreign import javascript "$1.id" default_sid :: JSVal -> JSVal
foreign import javascript "$1.my" def_my :: JSVal -> Bool
foreign import javascript "$1.owner" def_owner :: JSVal -> User
foreign import javascript "$1.hits" def_hits :: JSVal -> Int
foreign import javascript "$1.hitsMax" def_hits_max :: JSVal -> Int
foreign import javascript "$1.name" js_name :: JSVal -> JSString
foreign import javascript "$1.notifyWhenAttacked($2)" js_notifyWhenAttacked :: JSVal -> Bool -> IO ReturnCode
foreign import javascript "$1.pos" js_pos :: JSVal -> RoomPosition
foreign import javascript "$1.store" default_store :: JSVal -> Store


foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_construction_site :: JSVal -> JSVal
foreign import javascript "$1 instanceof Creep || $1 instanceof PowerCreep ? $1 : null" maybe_shared_creep :: JSVal -> JSVal
foreign import javascript "$1 instanceof Creep ? $1 : null" maybe_creep :: JSVal -> JSVal
foreign import javascript "$1 instanceof PowerCreep ? $1 : null" maybe_power_creep :: JSVal -> JSVal
foreign import javascript "$1 instanceof Resource ? $1 : null" maybe_resource :: JSVal -> JSVal
foreign import javascript "$1 instanceof Source ? $1 : null" maybe_source :: JSVal -> JSVal
foreign import javascript "$1 instanceof Deposit ? $1 : null" maybe_deposit :: JSVal -> JSVal
foreign import javascript "$1 instanceof Mineral ? $1 : null" maybe_mineral :: JSVal -> JSVal
foreign import javascript "$1 instanceof Flag ? $1 : null" maybe_flag :: JSVal -> JSVal
foreign import javascript "$1 instanceof Nuke ? $1 : null" maybe_nuke :: JSVal -> JSVal
foreign import javascript "$1 instanceof Ruin ? $1 : null" maybe_ruin :: JSVal -> JSVal
foreign import javascript "$1 instanceof Tombstone ? $1 : null" maybe_tombstone :: JSVal -> JSVal
foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_structure :: JSVal -> JSVal
foreign import javascript "$1 instanceof OwnedStructure ? $1 : null" maybe_owned_structure :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureController ? $1 : null" maybe_structure_controller :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureSpawn ? $1 : null" maybe_structure_spawn :: JSVal -> JSVal
