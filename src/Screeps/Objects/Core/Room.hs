{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Core.Room
  ( Room(..)
  ) where

import Screeps.Core
import Screeps.Memory

newtype Room = Room JSObject deriving (JSRef, JSShow)
instance HasMemory Room where memory x = Memory ["rooms", name x]

foreign import javascript "$1.name" name :: Room -> JSString
