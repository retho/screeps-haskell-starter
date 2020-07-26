{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.RoomPosition
  ( RoomPosition(..)
  , HasRoomPosition(..)
  , new
  , roomName
  , _x
  , _y
  , isNearTo
  ) where

import Screeps.Core

newtype RoomPosition = RoomPosition JSObject deriving (JSRef, JSShow)
instance HasRoomPosition RoomPosition where pos = id

class JSRef a => HasRoomPosition a where
  pos :: a -> RoomPosition
  pos = js_pos . toJSRef

foreign import javascript "new RoomPosition($1, $2, $3)" new :: Int -> Int -> JSString -> RoomPosition

foreign import javascript "$1.roomName" roomName :: RoomPosition -> JSString
foreign import javascript "$1.x" _x :: RoomPosition -> Int
foreign import javascript "$1.y" _y :: RoomPosition -> Int

isNearTo :: (HasRoomPosition a, HasRoomPosition b) => a -> b -> Bool
isNearTo xx yy = is_near_to (pos xx) (pos yy)


-- *

foreign import javascript "$1.isNearTo($2)" is_near_to :: RoomPosition -> RoomPosition -> Bool
foreign import javascript "$1.pos" js_pos :: JSVal -> RoomPosition
