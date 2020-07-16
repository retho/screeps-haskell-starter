{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Creep
  ( Creep(..)
  ) where

import Screeps.Core

newtype Creep = Creep JSObject deriving (JSRef, JSShow)
