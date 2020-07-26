{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.ConstructionSite
  ( ConstructionSite()
  , progress
  , progressTotal
  , structureType
  , remove
  ) where

import Screeps.Utils
import Screeps.Core

foreign import javascript "$1.progress" progress :: ConstructionSite -> Int
foreign import javascript "$1.progressTotal" progressTotal :: ConstructionSite -> Int
foreign import javascript "$1.structureType" structureType :: ConstructionSite -> StructureType

foreign import javascript "$1.remove()" remove :: ConstructionSite -> IO ()

-- *
