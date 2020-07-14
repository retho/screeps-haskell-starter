{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Objects.Creep
  ( Creep()
  ) where

import Screeps.Prelude

newtype Creep = Creep JSObj deriving (JSRef, JSShow)
