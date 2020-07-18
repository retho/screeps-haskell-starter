{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Source
  ( module RoomObject
  , Source(..)
  ) where

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype Source = Source RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance Harvestable Source where asHarvestable = coerce
instance IsRoomObject Source where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_source . toJSRef

-- *

foreign import javascript "$1 instanceof Source ? $1 : null" maybe_source :: JSVal -> JSVal

