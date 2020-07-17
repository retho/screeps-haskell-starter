{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Room
  ( Room(..)
  , name
  ) where

import Screeps.Core

newtype Room = Room JSObject deriving (JSRef, JSShow)

foreign import javascript "name" name :: Room -> JSString
