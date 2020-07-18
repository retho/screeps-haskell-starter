{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.RoomPosition
  ( RoomPosition(..)
  , HasRoomPosition(..)
  , new
  , roomName
  , x
  , y
  , isNearTo
  ) where

import Screeps.Core

newtype RoomPosition = RoomPosition JSObject deriving (JSRef, JSShow)
instance HasRoomPosition RoomPosition where pos = id

class HasRoomPosition a where
  pos :: a -> RoomPosition

foreign import javascript "new RoomPosition($1, $2, $3)" new :: Int -> Int -> JSString -> RoomPosition

foreign import javascript "$1.roomName" roomName :: RoomPosition -> JSString
foreign import javascript "$1.x" x :: RoomPosition -> Int
foreign import javascript "$1.y" y :: RoomPosition -> Int

isNearTo :: (HasRoomPosition a, HasRoomPosition b) => a -> b -> Bool
isNearTo x y = is_near_to (pos x) (pos y)


-- *

foreign import javascript "$1.isNearTo($2)" is_near_to :: RoomPosition -> RoomPosition -> Bool
