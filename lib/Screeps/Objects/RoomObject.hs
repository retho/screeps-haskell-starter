{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.RoomObject
  ( RoomObject(..)
  , IsRoomObject(..)
  , room
  , effects
  ) where

import Screeps.Core
import Screeps.Objects.Core.Room
import Screeps.Objects.RoomPosition

newtype RoomObject = RoomObject JSObject deriving (JSRef, JSShow)
instance HasRoomPosition RoomObject
instance IsRoomObject RoomObject where
  asRoomObject = id
  fromRoomObject = pure

class HasRoomPosition a => IsRoomObject a where
  asRoomObject :: a -> RoomObject
  fromRoomObject :: RoomObject -> Maybe a

room :: IsRoomObject a => a -> Room
room = raw_room . asRoomObject

newtype RoomObjectEffect = RoomObjectEffect JSObject deriving JSRef
effects :: IsRoomObject a => a -> [RoomObjectEffect]
effects = fromJSRef . raw_effects . asRoomObject


foreign import javascript "$1.room" raw_room :: RoomObject -> Room
foreign import javascript "$1.effects" raw_effects :: RoomObject -> JSVal
