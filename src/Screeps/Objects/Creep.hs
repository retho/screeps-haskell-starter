{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Creep
  ( Creep(..)
  ) where

import Screeps.Prelude

newtype Creep = Creep JSObject deriving (JSRef, JSShow)
