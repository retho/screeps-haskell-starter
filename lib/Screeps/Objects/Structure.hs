{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Structure
  ( module RoomObject
  , Structure(..)
  , IsStructure(..)
  , hits
  , hitsMax
  ) where

import Screeps.Core
import Screeps.Objects.Classes
import Screeps.Objects.RoomPosition
import Screeps.Objects.RoomObject as RoomObject

newtype Structure = Structure RoomObject deriving (HasRoomPosition, JSRef, JSShow)
instance HasScreepsId Structure where sid = defaultSid
instance IsRoomObject Structure where
  asRoomObject = coerce
  fromRoomObject = fromJSRef . maybe_structure . toJSRef
instance IsStructure Structure where
  asStructure = id
  fromStructure = pure

class IsRoomObject a => IsStructure a where
  asStructure :: a -> Structure
  fromStructure :: Structure -> Maybe a


hits :: IsStructure a => a -> Int
hits = raw_hits . asStructure

hitsMax :: IsStructure a => a -> Int
hitsMax = raw_hits_max . asStructure


foreign import javascript "$1 instanceof Structure ? $1 : null" maybe_structure :: JSVal -> JSVal

foreign import javascript "$1.hits" raw_hits :: Structure -> Int
foreign import javascript "$1.hits" raw_hits_max :: Structure -> Int
