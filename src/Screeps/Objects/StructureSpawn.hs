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

instance HasStore StructureSpawn where store = defaultStore
instance HasId StructureSpawn where sid = defaultSid

foreign import javascript "$1.name" name :: StructureSpawn -> JSString

spawnCreep :: StructureSpawn -> [BodyPart] -> JSString -> IO ReturnCode
spawnCreep spawn body name = spawn_creep spawn (toJSRef body) name


-- *

foreign import javascript "$1.spawnCreep($2, $3)" spawn_creep :: StructureSpawn -> JSVal -> JSString -> IO ReturnCode
