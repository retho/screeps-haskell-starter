{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Internal.Objects
  ( ScreepsId(..)
  , User(..)
  , username
  , Room(..)
  , RoomPosition(..)
  , Store(..)
  , RoomObject(..)
  , ConstructionSite(..)
  , SharedCreep(..)
  , Creep(..)
  , PowerCreep(..)
  , Resource(..)
  , Deposit(..)
  , Flag(..)
  , Mineral(..)
  , Nuke(..)
  , Ruin(..)
  , Tombstone(..)
  , Source(..)
  , Structure(..)
  , OwnedStructure(..)
  ) where

import Screeps.Utils
import Screeps.Internal.Constants
import Data.String (IsString)


newtype ScreepsId a = ScreepsId JSString deriving (IsString, JSShow, JSIndex, JSRef, Eq)

newtype User = User JSObject deriving (JSRef, JSShow)
username :: User -> JSString
username = js_username . coerce
foreign import javascript "$1.username" js_username :: JSVal -> JSString

newtype Room = Room JSObject deriving (JSRef, JSShow)

newtype RoomPosition = RoomPosition JSObject deriving (JSRef, JSShow)

newtype Store = Store JSObject deriving (JSRef, JSShow)
instance AsJSHashMap Store ResourceType Int where hashmap = defaultHashmap

newtype RoomObject = RoomObject JSObject deriving (JSRef, JSShow)

newtype ConstructionSite = ConstructionSite RoomObject deriving (JSRef, JSShow)

newtype Resource = Resource RoomObject deriving (JSRef, JSShow)

newtype Source = Source RoomObject deriving (JSRef, JSShow)

newtype Deposit = Deposit RoomObject deriving (JSRef, JSShow)

newtype Flag = Flag RoomObject deriving (JSRef, JSShow)

newtype Mineral = Mineral RoomObject deriving (JSRef, JSShow)

newtype Nuke = Nuke RoomObject deriving (JSRef, JSShow)

newtype Ruin = Ruin RoomObject deriving (JSRef, JSShow)

newtype Tombstone = Tombstone RoomObject deriving (JSRef, JSShow)

newtype SharedCreep = SharedCreep RoomObject deriving (JSRef, JSShow)

newtype Creep = Creep SharedCreep deriving (JSRef, JSShow)

newtype PowerCreep = PowerCreep SharedCreep deriving (JSRef, JSShow)

newtype Structure = Structure RoomObject deriving (JSRef, JSShow)

newtype OwnedStructure = OwnedStructure Structure deriving (JSRef, JSShow)
