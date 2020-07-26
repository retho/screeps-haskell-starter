{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.StructureType
  ( StructureType(..)
  , spawn
  , extension
  , road
  , wall
  , rampart
  , keeper_lair
  , portal
  , controller
  , link
  , storage
  , tower
  , observer
  , power_bank
  , power_spawn
  , extractor
  , lab
  , terminal
  , container
  , nuker
  , factory
  , invader_core
  ) where

import Screeps.Utils

newtype StructureType = StructureType JSString deriving (JSShow, JSIndex, JSRef, Eq)

foreign import javascript "STRUCTURE_SPAWN" spawn :: StructureType
foreign import javascript "STRUCTURE_EXTENSION" extension :: StructureType
foreign import javascript "STRUCTURE_ROAD" road :: StructureType
foreign import javascript "STRUCTURE_WALL" wall :: StructureType
foreign import javascript "STRUCTURE_RAMPART" rampart :: StructureType
foreign import javascript "STRUCTURE_KEEPER_LAIR" keeper_lair :: StructureType
foreign import javascript "STRUCTURE_PORTAL" portal :: StructureType
foreign import javascript "STRUCTURE_CONTROLLER" controller :: StructureType
foreign import javascript "STRUCTURE_LINK" link :: StructureType
foreign import javascript "STRUCTURE_STORAGE" storage :: StructureType
foreign import javascript "STRUCTURE_TOWER" tower :: StructureType
foreign import javascript "STRUCTURE_OBSERVER" observer :: StructureType
foreign import javascript "STRUCTURE_POWER_BANK" power_bank :: StructureType
foreign import javascript "STRUCTURE_POWER_SPAWN" power_spawn :: StructureType
foreign import javascript "STRUCTURE_EXTRACTOR" extractor :: StructureType
foreign import javascript "STRUCTURE_LAB" lab :: StructureType
foreign import javascript "STRUCTURE_TERMINAL" terminal :: StructureType
foreign import javascript "STRUCTURE_CONTAINER" container :: StructureType
foreign import javascript "STRUCTURE_NUKER" nuker :: StructureType
foreign import javascript "STRUCTURE_FACTORY" factory :: StructureType
foreign import javascript "STRUCTURE_INVADER_CORE" invader_core :: StructureType
