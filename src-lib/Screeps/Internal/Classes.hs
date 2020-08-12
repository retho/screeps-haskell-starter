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

class (IsRoomObject a, HasScreepsId a, HasStore a, HasName a, HasOwner a, Attackable a, Transferable a, NotifyWhenAttacked a) => IsSharedCreep a where
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
-- *
instance HasScreepsId StructureContainer
instance HasScreepsId StructureController
instance HasScreepsId StructureExtension
instance HasScreepsId StructureExtractor
instance HasScreepsId StructureFactory
instance HasScreepsId StructureInvaderCore
instance HasScreepsId StructureKeeperLair
instance HasScreepsId StructureLab
instance HasScreepsId StructureLink
instance HasScreepsId StructureNuker
instance HasScreepsId StructureObserver
instance HasScreepsId StructurePowerBank
instance HasScreepsId StructurePowerSpawn
instance HasScreepsId StructurePortal
instance HasScreepsId StructureRampart
instance HasScreepsId StructureRoad
instance HasScreepsId StructureSpawn
instance HasScreepsId StructureStorage
instance HasScreepsId StructureTerminal
instance HasScreepsId StructureTower
instance HasScreepsId StructureWall


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
-- *
instance HasOwner StructureController
instance HasOwner StructureExtension
instance HasOwner StructureExtractor
instance HasOwner StructureFactory
instance HasOwner StructureInvaderCore
instance HasOwner StructureKeeperLair
instance HasOwner StructureLab
instance HasOwner StructureLink
instance HasOwner StructureNuker
instance HasOwner StructureObserver
instance HasOwner StructurePowerSpawn
instance HasOwner StructureRampart
instance HasOwner StructureSpawn
instance HasOwner StructureStorage
instance HasOwner StructureTerminal
instance HasOwner StructureTower


instance HasStore Store where store = id
instance HasStore SharedCreep
instance HasStore Creep
instance HasStore PowerCreep
-- *
instance HasStore StructureContainer
instance HasStore StructureExtension
instance HasStore StructureFactory
instance HasStore StructureLab
instance HasStore StructureLink
instance HasStore StructureNuker
instance HasStore StructurePowerSpawn
instance HasStore StructureSpawn
instance HasStore StructureStorage
instance HasStore StructureTerminal
instance HasStore StructureTower


instance Attackable SharedCreep
instance Attackable Creep
instance Attackable PowerCreep
instance Attackable Structure
instance Attackable OwnedStructure
-- *
instance Attackable StructureContainer
instance Attackable StructureController
instance Attackable StructureExtension
instance Attackable StructureExtractor
instance Attackable StructureFactory
instance Attackable StructureInvaderCore
instance Attackable StructureKeeperLair
instance Attackable StructureLab
instance Attackable StructureLink
instance Attackable StructureNuker
instance Attackable StructureObserver
instance Attackable StructurePowerBank
instance Attackable StructurePowerSpawn
instance Attackable StructurePortal
instance Attackable StructureRampart
instance Attackable StructureRoad
instance Attackable StructureSpawn
instance Attackable StructureStorage
instance Attackable StructureTerminal
instance Attackable StructureTower
instance Attackable StructureWall


instance Transferable SharedCreep
instance Transferable Creep
instance Transferable PowerCreep
instance Transferable Structure
-- *
instance Transferable StructureContainer
instance Transferable StructureExtension
instance Transferable StructureFactory
instance Transferable StructureLab
instance Transferable StructureLink
instance Transferable StructureNuker
instance Transferable StructurePowerSpawn
instance Transferable StructureSpawn
instance Transferable StructureStorage
instance Transferable StructureTerminal
instance Transferable StructureTower


instance Withdrawable Tombstone
instance Withdrawable Ruin
instance Withdrawable Structure
-- *
instance Withdrawable StructureContainer
instance Withdrawable StructureExtension
instance Withdrawable StructureFactory
instance Withdrawable StructureLab
instance Withdrawable StructureLink
instance Withdrawable StructureNuker
instance Withdrawable StructurePowerSpawn
instance Withdrawable StructureSpawn
instance Withdrawable StructureStorage
instance Withdrawable StructureTerminal
instance Withdrawable StructureTower


instance NotifyWhenAttacked SharedCreep
instance NotifyWhenAttacked Creep
instance NotifyWhenAttacked PowerCreep
instance NotifyWhenAttacked Structure
instance NotifyWhenAttacked OwnedStructure
-- *
instance NotifyWhenAttacked StructureContainer
instance NotifyWhenAttacked StructureController
instance NotifyWhenAttacked StructureExtension
instance NotifyWhenAttacked StructureExtractor
instance NotifyWhenAttacked StructureFactory
instance NotifyWhenAttacked StructureInvaderCore
instance NotifyWhenAttacked StructureKeeperLair
instance NotifyWhenAttacked StructureLab
instance NotifyWhenAttacked StructureLink
instance NotifyWhenAttacked StructureNuker
instance NotifyWhenAttacked StructureObserver
instance NotifyWhenAttacked StructurePowerBank
instance NotifyWhenAttacked StructurePowerSpawn
instance NotifyWhenAttacked StructurePortal
instance NotifyWhenAttacked StructureRampart
instance NotifyWhenAttacked StructureRoad
instance NotifyWhenAttacked StructureSpawn
instance NotifyWhenAttacked StructureStorage
instance NotifyWhenAttacked StructureTerminal
instance NotifyWhenAttacked StructureTower
instance NotifyWhenAttacked StructureWall


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
-- *
instance HasRoomPosition StructureContainer
instance HasRoomPosition StructureController
instance HasRoomPosition StructureExtension
instance HasRoomPosition StructureExtractor
instance HasRoomPosition StructureFactory
instance HasRoomPosition StructureInvaderCore
instance HasRoomPosition StructureKeeperLair
instance HasRoomPosition StructureLab
instance HasRoomPosition StructureLink
instance HasRoomPosition StructureNuker
instance HasRoomPosition StructureObserver
instance HasRoomPosition StructurePowerBank
instance HasRoomPosition StructurePowerSpawn
instance HasRoomPosition StructurePortal
instance HasRoomPosition StructureRampart
instance HasRoomPosition StructureRoad
instance HasRoomPosition StructureSpawn
instance HasRoomPosition StructureStorage
instance HasRoomPosition StructureTerminal
instance HasRoomPosition StructureTower
instance HasRoomPosition StructureWall


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
-- *
instance IsRoomObject StructureContainer where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_container . toJSRef
instance IsRoomObject StructureController where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_controller . toJSRef
instance IsRoomObject StructureExtension where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_extension . toJSRef
instance IsRoomObject StructureExtractor where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_extractor . toJSRef
instance IsRoomObject StructureFactory where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_factory . toJSRef
instance IsRoomObject StructureInvaderCore where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_invader_core . toJSRef
instance IsRoomObject StructureKeeperLair where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_keeper_lair . toJSRef
instance IsRoomObject StructureLab where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_lab . toJSRef
instance IsRoomObject StructureLink where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_link . toJSRef
instance IsRoomObject StructureNuker where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_nuker . toJSRef
instance IsRoomObject StructureObserver where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_observer . toJSRef
instance IsRoomObject StructurePowerBank where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_power_bank . toJSRef
instance IsRoomObject StructurePowerSpawn where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_power_spawn . toJSRef
instance IsRoomObject StructurePortal where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_portal . toJSRef
instance IsRoomObject StructureRampart where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_rampart . toJSRef
instance IsRoomObject StructureRoad where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_road . toJSRef
instance IsRoomObject StructureSpawn where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_spawn . toJSRef
instance IsRoomObject StructureStorage where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_storage . toJSRef
instance IsRoomObject StructureTerminal where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_terminal . toJSRef
instance IsRoomObject StructureTower where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_tower . toJSRef
instance IsRoomObject StructureWall where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure_wall . toJSRef


instance IsStructure Structure where
  asStructure = id
  fromStructure = pure
instance IsStructure OwnedStructure where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_owned_structure . toJSRef
-- *
instance IsStructure StructureContainer where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_container . toJSRef
instance IsStructure StructureController where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_controller . toJSRef
instance IsStructure StructureExtension where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_extension . toJSRef
instance IsStructure StructureExtractor where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_extractor . toJSRef
instance IsStructure StructureFactory where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_factory . toJSRef
instance IsStructure StructureInvaderCore where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_invader_core . toJSRef
instance IsStructure StructureKeeperLair where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_keeper_lair . toJSRef
instance IsStructure StructureLab where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_lab . toJSRef
instance IsStructure StructureLink where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_link . toJSRef
instance IsStructure StructureNuker where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_nuker . toJSRef
instance IsStructure StructureObserver where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_observer . toJSRef
instance IsStructure StructurePowerBank where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_power_bank . toJSRef
instance IsStructure StructurePowerSpawn where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_power_spawn . toJSRef
instance IsStructure StructurePortal where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_portal . toJSRef
instance IsStructure StructureRampart where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_rampart . toJSRef
instance IsStructure StructureRoad where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_road . toJSRef
instance IsStructure StructureSpawn where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_spawn . toJSRef
instance IsStructure StructureStorage where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_storage . toJSRef
instance IsStructure StructureTerminal where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_terminal . toJSRef
instance IsStructure StructureTower where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_tower . toJSRef
instance IsStructure StructureWall where
  asStructure = coerce
  fromStructure = fromJSRef . maybe_structure_wall . toJSRef


instance IsOwnedStructure OwnedStructure where
  asOwnedStructure = id
  fromOwnedStruture = pure
-- *
instance IsOwnedStructure StructureController where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_controller . toJSRef
instance IsOwnedStructure StructureExtension where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_extension . toJSRef
instance IsOwnedStructure StructureExtractor where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_extractor . toJSRef
instance IsOwnedStructure StructureFactory where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_factory . toJSRef
instance IsOwnedStructure StructureInvaderCore where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_invader_core . toJSRef
instance IsOwnedStructure StructureKeeperLair where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_keeper_lair . toJSRef
instance IsOwnedStructure StructureLab where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_lab . toJSRef
instance IsOwnedStructure StructureLink where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_link . toJSRef
instance IsOwnedStructure StructureNuker where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_nuker . toJSRef
instance IsOwnedStructure StructureObserver where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_observer . toJSRef
instance IsOwnedStructure StructurePowerSpawn where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_power_spawn . toJSRef
instance IsOwnedStructure StructureRampart where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_rampart . toJSRef
instance IsOwnedStructure StructureSpawn where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_spawn . toJSRef
instance IsOwnedStructure StructureStorage where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_storage . toJSRef
instance IsOwnedStructure StructureTerminal where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_terminal . toJSRef
instance IsOwnedStructure StructureTower where
  asOwnedStructure = coerce
  fromOwnedStruture = fromJSRef . maybe_structure_tower . toJSRef


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
-- *
foreign import javascript "$1 instanceof StructureContainer ? $1 : null" maybe_structure_container :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureController ? $1 : null" maybe_structure_controller :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureExtension ? $1 : null" maybe_structure_extension :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureExtractor ? $1 : null" maybe_structure_extractor :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureFactory ? $1 : null" maybe_structure_factory :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureInvaderCore ? $1 : null" maybe_structure_invader_core :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureKeeperLair ? $1 : null" maybe_structure_keeper_lair :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureLab ? $1 : null" maybe_structure_lab :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureLink ? $1 : null" maybe_structure_link :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureNuker ? $1 : null" maybe_structure_nuker :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureObserver ? $1 : null" maybe_structure_observer :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructurePowerBank ? $1 : null" maybe_structure_power_bank :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructurePowerSpawn ? $1 : null" maybe_structure_power_spawn :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructurePortal ? $1 : null" maybe_structure_portal :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureRampart ? $1 : null" maybe_structure_rampart :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureRoad ? $1 : null" maybe_structure_road :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureSpawn ? $1 : null" maybe_structure_spawn :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureStorage ? $1 : null" maybe_structure_storage :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureTerminal ? $1 : null" maybe_structure_terminal :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureTower ? $1 : null" maybe_structure_tower :: JSVal -> JSVal
foreign import javascript "$1 instanceof StructureWall ? $1 : null" maybe_structure_wall :: JSVal -> JSVal
