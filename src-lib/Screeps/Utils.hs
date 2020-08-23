module Screeps.Utils
  ( module Ffi
  , module JSShow
  , module Default
  , consoleLog
  ) where

import Screeps.Utils.Ffi as Ffi
import Screeps.Utils.JSShow as JSShow
import Screeps.Utils.Default as Default

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
