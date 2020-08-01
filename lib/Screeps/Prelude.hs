
module Screeps.Prelude
  ( module Utils
  , module Core
  , module Common
  , consoleLog
  ) where

import Screeps.Utils as Utils hiding (Coercible, coerce)
import Screeps.Internal as Core
  ( ScreepsId()
  , HasScreepsId(..)
  , Harvestable(..)
  , HasOwner(..)
  , Attackable(..)
  , hits
  , hitsMax
  , HasName(..)
  , Transferable(..)
  , Withdrawable(..)
  , NotifyWhenAttacked(..)
  , HasRoomPosition(..)
  , IsRoomObject(..)
  , HasStore(..)
  , IsSharedCreep(..)
  , IsStructure(..)
  )
import Screeps.Memory as Common (HasMemory(..))
import Screeps.Objects.Store as Common (storeCapacity, storeFreeCapacity, storeUsedCapacity)


foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
