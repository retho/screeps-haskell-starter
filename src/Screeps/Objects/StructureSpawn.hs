{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.StructureSpawn
  ( StructureSpawn(..)
  , name
  , store
  , spawnCreep
  ) where

import Screeps.Prelude

import Screeps.Objects.Store
import Screeps.Constants.BodyPart
import Screeps.Constants.ReturnCode

newtype StructureSpawn = StructureSpawn JSObject deriving (JSRef, JSShow)

foreign import javascript "$1.name" name :: StructureSpawn -> JSString
foreign import javascript "$1.store" store :: StructureSpawn -> Store

spawnCreep :: StructureSpawn -> [BodyPart] -> JSString -> IO ReturnCode
spawnCreep spawn body name = spawn_creep spawn (toJSVal body) name


-- * ffi

foreign import javascript "$1.spawnCreep($2, $3)" spawn_creep :: StructureSpawn -> JSVal -> JSString -> IO ReturnCode
