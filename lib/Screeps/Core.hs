{-# LANGUAGE OverloadedStrings #-}

module Screeps.Core
  ( module Ffi
  , module JSShow
  , module Default
  , consoleLog
  ) where

import Screeps.Core.Ffi as Ffi
import Screeps.Core.JSShow as JSShow
import Screeps.Core.Default as Default

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
