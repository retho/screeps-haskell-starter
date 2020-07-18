{-# LANGUAGE OverloadedStrings #-}

module Screeps.Core
  ( module Ffi
  , module JSShow
  , consoleLog
  ) where

import Screeps.Core.Ffi as Ffi
import Screeps.Core.JSShow as JSShow

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
