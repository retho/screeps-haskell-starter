{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.Resource
  ( Resource(..)
  , energy
  ) where

import Screeps.Core

newtype Resource = Resource JSString deriving (JSShow, JSIndex, JSRef, Eq)

foreign import javascript "RESOURCE_ENERGY" energy :: Resource
