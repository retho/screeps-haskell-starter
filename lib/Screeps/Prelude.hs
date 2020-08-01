
module Screeps.Prelude
  ( module Utils
  , module Classes
  , module Common
  , consoleLog
  ) where

import Screeps.Utils as Utils hiding (Coercible, coerce)
import Screeps.Internal.Classes as Classes
import Screeps.Memory as Common (HasMemory(..))
import Screeps.Objects.Store as Common (storeCapacity, storeFreeCapacity, storeUsedCapacity)


foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
