{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.FindConstant
  ( find_exit_top
  , find_exit_right
  , find_exit_bottom
  , find_exit_left
  , find_exit

  , find_creeps
  , find_my_creeps
  , find_hostile_creeps

  , find_sources_active
  , find_sources

  , find_dropped_resources

  , find_structures
  , find_my_structures
  , find_hostile_structures

  , find_flags

  , find_my_spawns
  , find_hostile_spawns

  , find_construction_sites
  , find_my_construction_sites
  , find_hostile_construction_sites

  , find_minerals
  , find_nukes
  , find_tombstones

  , find_power_creeps
  , find_my_power_creeps
  , find_hostile_power_creeps
  , find_deposits
  , find_ruins
  ) where

import Screeps.Constants.Core.FindConstant
import Screeps.Objects.Resource
import Screeps.Objects.RoomPosition
import Screeps.Objects.Creep
import Screeps.Objects.Structure
import Screeps.Objects.Structure.StructureSpawn
import Screeps.Objects.Source

type Unknown = ()
type Flag = Unknown
type ConstructionSite = Unknown
type Mineral = Unknown
type Nuke = Unknown
type Tombstone = Unknown

foreign import javascript "FIND_EXIT_TOP" find_exit_top :: FindConstant RoomPosition
foreign import javascript "FIND_EXIT_RIGHT" find_exit_right :: FindConstant RoomPosition
foreign import javascript "FIND_EXIT_BOTTOM" find_exit_bottom :: FindConstant RoomPosition
foreign import javascript "FIND_EXIT_LEFT" find_exit_left :: FindConstant RoomPosition
foreign import javascript "FIND_EXIT" find_exit :: FindConstant RoomPosition

foreign import javascript "FIND_CREEPS" find_creeps :: FindConstant Creep
foreign import javascript "FIND_MY_CREEPS" find_my_creeps :: FindConstant Creep
foreign import javascript "FIND_HOSTILE_CREEPS" find_hostile_creeps :: FindConstant Creep

foreign import javascript "FIND_SOURCES_ACTIVE" find_sources_active :: FindConstant Source
foreign import javascript "FIND_SOURCES" find_sources :: FindConstant Source

foreign import javascript "FIND_DROPPED_RESOURCES" find_dropped_resources :: FindConstant Resource

foreign import javascript "FIND_STRUCTURES" find_structures :: FindConstant Structure
foreign import javascript "FIND_MY_STRUCTURES" find_my_structures :: FindConstant Structure
foreign import javascript "FIND_HOSTILE_STRUCTURES" find_hostile_structures :: FindConstant Structure

foreign import javascript "FIND_FLAGS" find_flags :: FindConstant Flag

foreign import javascript "FIND_MY_SPAWNS" find_my_spawns :: FindConstant StructureSpawn
foreign import javascript "FIND_HOSTILE_SPAWNS" find_hostile_spawns :: FindConstant StructureSpawn

foreign import javascript "FIND_CONSTRUCTION_SITES" find_construction_sites :: FindConstant ConstructionSite
foreign import javascript "FIND_MY_CONSTRUCTION_SITES" find_my_construction_sites :: FindConstant ConstructionSite
foreign import javascript "FIND_HOSTILE_CONSTRUCTION_SITES" find_hostile_construction_sites :: FindConstant ConstructionSite

foreign import javascript "FIND_MINERALS" find_minerals :: FindConstant Mineral
foreign import javascript "FIND_NUKES" find_nukes :: FindConstant Nuke
foreign import javascript "FIND_TOMBSTONES" find_tombstones :: FindConstant Tombstone

foreign import javascript "FIND_POWER_CREEPS" find_power_creeps :: FindConstant Unknown
foreign import javascript "FIND_MY_POWER_CREEPS" find_my_power_creeps :: FindConstant Unknown
foreign import javascript "FIND_HOSTILE_POWER_CREEPS" find_hostile_power_creeps :: FindConstant Unknown
foreign import javascript "FIND_DEPOSITS" find_deposits :: FindConstant Unknown
foreign import javascript "FIND_RUINS" find_ruins :: FindConstant Unknown

