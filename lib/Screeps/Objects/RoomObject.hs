{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.RoomObject
  ( RoomObject()
  , room
  , effects
  ) where

import Screeps.Utils
import Screeps.Core


room :: IsRoomObject a => a -> Room
room = raw_room . asRoomObject

newtype RoomObjectEffect = RoomObjectEffect JSObject deriving JSRef
effects :: IsRoomObject a => a -> [RoomObjectEffect]
effects = fromJSRef . raw_effects . asRoomObject


foreign import javascript "$1.room" raw_room :: RoomObject -> Room
foreign import javascript "$1.effects" raw_effects :: RoomObject -> JSVal
