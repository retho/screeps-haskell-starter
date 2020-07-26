{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Primitives.User
  ( User(..)
  , _username
  ) where

import Screeps.Core

newtype User = User JSObject deriving (JSRef, JSShow)

_username :: User -> JSString
_username = js_username . coerce

foreign import javascript "$1.username" js_username :: JSVal -> JSString
