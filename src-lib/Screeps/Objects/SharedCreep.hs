{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.SharedCreep
  ( module RoomObject
  , SharedCreep()
  , saying
  , ticksToLive
  , drop
  , drop'
  , moveTo
  , moveTo'
  , pickup
  , say
  , say'
  , suicide
  , transfer
  , transfer'
  , withdraw
  , withdraw'
  ) where

import Prelude hiding (drop)
import Screeps.Utils
import Screeps.Internal

import Screeps.Objects.RoomObject as RoomObject
import Screeps.Objects.Options.SharedCreep


saying :: IsSharedCreep c => c -> JSString
ticksToLive :: IsSharedCreep c => c -> Int

drop :: IsSharedCreep c => c -> ResourceType -> IO ReturnCode
drop' :: IsSharedCreep c => c -> ResourceType -> Int -> IO ReturnCode
moveTo :: (IsSharedCreep c, HasRoomPosition a) => c -> a -> IO ReturnCode
moveTo' :: (IsSharedCreep c, HasRoomPosition a) => c -> a -> MoveToOptions -> IO ReturnCode
pickup :: IsSharedCreep c => c -> Resource -> IO ReturnCode
say :: IsSharedCreep c => c -> JSString -> IO ReturnCode
say' :: IsSharedCreep c => c -> JSString -> Bool -> IO ReturnCode
suicide :: IsSharedCreep c => c -> IO ReturnCode
transfer :: (IsSharedCreep c, Transferable a) => c -> a -> ResourceType -> IO ReturnCode
transfer' :: (IsSharedCreep c, Transferable a) => c -> a -> ResourceType -> Int -> IO ReturnCode
withdraw :: (IsSharedCreep c, Withdrawable a) => c -> a -> IO ReturnCode
withdraw' :: (IsSharedCreep c, Withdrawable a) => c -> a -> Int -> IO ReturnCode


-- *
saying = js_saying . asSharedCreep
ticksToLive = js_ticksToLive . asSharedCreep

drop self resource_type = js_drop (asSharedCreep self) resource_type
drop' self resource_type amount = js_drop' (asSharedCreep self) resource_type amount
moveTo self terget = js_moveTo (asSharedCreep self) (pos terget)
moveTo' self terget opts = js_moveTo' (asSharedCreep self) (pos terget) (toJSRef opts)
pickup self resource_type = js_pickup (asSharedCreep self) resource_type
say self text = js_say (asSharedCreep self) text
say' self text public = js_say' (asSharedCreep self) text public
suicide self = js_suicide (asSharedCreep self)
transfer self target resource_type = js_transfer (asSharedCreep self) (asTransferable target) resource_type
transfer' self target resource_type amount = js_transfer' (asSharedCreep self) (asTransferable target) resource_type amount
withdraw self target = js_withdraw (asSharedCreep self) (asWithdrawable target)
withdraw' self target amount = js_withdraw' (asSharedCreep self) (asWithdrawable target) amount


foreign import javascript "$1.saying" js_saying :: SharedCreep -> JSString
foreign import javascript "$1.ticksToLive" js_ticksToLive :: SharedCreep -> Int

foreign import javascript "$1.drop($2)" js_drop :: SharedCreep -> ResourceType -> IO ReturnCode
foreign import javascript "$1.drop($2, $3)" js_drop' :: SharedCreep -> ResourceType -> Int -> IO ReturnCode
foreign import javascript "$1.moveTo($2)" js_moveTo :: SharedCreep -> RoomPosition -> IO ReturnCode
foreign import javascript "$1.moveTo($2, $3)" js_moveTo' :: SharedCreep -> RoomPosition -> JSVal -> IO ReturnCode
foreign import javascript "$1.pickup($2)" js_pickup :: SharedCreep -> Resource -> IO ReturnCode
foreign import javascript "$1.say($2)" js_say :: SharedCreep -> JSString -> IO ReturnCode
foreign import javascript "$1.say($2, $3)" js_say' :: SharedCreep -> JSString -> Bool -> IO ReturnCode
foreign import javascript "$1.suicide()" js_suicide :: SharedCreep -> IO ReturnCode
foreign import javascript "$1.transfer($2, $3)" js_transfer :: SharedCreep -> JSVal -> ResourceType -> IO ReturnCode
foreign import javascript "$1.transfer($2, $3, $4)" js_transfer' :: SharedCreep -> JSVal -> ResourceType -> Int -> IO ReturnCode
foreign import javascript "$1.withdraw($2)" js_withdraw :: SharedCreep -> JSVal -> IO ReturnCode
foreign import javascript "$1.withdraw($2, $3)" js_withdraw' :: SharedCreep -> JSVal -> Int -> IO ReturnCode

