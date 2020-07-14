{-# LANGUAGE OverloadedStrings #-}

module Screeps.Prelude
  ( module Ffi
  , module JSShow
  , consoleLog
  ) where

import Screeps.Prelude.Ffi as Ffi
import Screeps.Prelude.JSShow as JSShow

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
