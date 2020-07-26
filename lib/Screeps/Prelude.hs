
module Screeps.Prelude
  ( module Utils
  , module Core
  , module Common
  , consoleLog
  ) where

import Screeps.Utils as Utils hiding (Coercible, coerce)
import Screeps.Core as Core
import Screeps.Memory as Common (HasMemory(..))
import Screeps.Objects.Store as Common (HasStore(..), storeCapacity, storeFreeCapacity, storeUsedCapacity)
import Screeps.Objects.Classes as Common

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
