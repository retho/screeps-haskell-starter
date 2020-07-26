{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Game
  ( time
  , spawns
  , creeps
  , getObjectById
  ) where

import Screeps.Utils
import Screeps.Objects.Classes
import Screeps.Objects.Primitives.ScreepsId
import Screeps.Objects.Structure.StructureSpawn (StructureSpawn)
import Screeps.Objects.Creep (Creep)

foreign import javascript "Game.time" time :: IO Int
foreign import javascript "Game.spawns" spawns :: IO (JSHashMap JSString StructureSpawn)
foreign import javascript "Game.creeps" creeps :: IO (JSHashMap JSString Creep)

getObjectById :: HasScreepsId a => ScreepsId a -> IO (Maybe a)
getObjectById x = get_object_by_id (toJSRef x) >>= pure . fromJSRef


-- *

foreign import javascript "Game.getObjectById($1)" get_object_by_id :: JSVal -> IO JSVal
