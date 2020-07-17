{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.RoomPosition
  ( RoomPosition(..)
  , new
  , roomName
  , x
  , y
  , HasRoomPosition(..)
  ) where

import Screeps.Core

newtype RoomPosition = RoomPosition JSObject deriving (JSRef, JSShow)

foreign import javascript "new RoomPosition($1, $2, $3)" new :: Int -> Int -> JSString -> RoomPosition

foreign import javascript "$1.roomName" roomName :: RoomPosition -> JSString
foreign import javascript "$1.x" x :: RoomPosition -> Int
foreign import javascript "$1.y" y :: RoomPosition -> Int

class HasRoomPosition a where
  pos :: a -> RoomPosition
