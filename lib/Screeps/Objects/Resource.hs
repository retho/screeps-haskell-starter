{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Resource
  ( module RoomObject
  , Resource(..)
  , amount
  , resourceType
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype Resource = Resource RoomObject deriving (JSRef, JSShow)
instance HasRoomPosition Resource
instance IsRoomObject Resource where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_resource . toJSRef
instance HasScreepsId Resource

foreign import javascript "$1.amount" amount :: Resource -> Int
foreign import javascript "$1.resourceType" resourceType :: Resource -> ResourceType


-- *

foreign import javascript "$1 instanceof Resource ? $1 : null" maybe_resource :: JSVal -> JSVal

