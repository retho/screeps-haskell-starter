{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.StructureSpawn
  ( StructureSpawn()
  ) where

import Screeps.Prelude

newtype StructureSpawn = StructureSpawn JSObj deriving (JSRef, JSShow)
