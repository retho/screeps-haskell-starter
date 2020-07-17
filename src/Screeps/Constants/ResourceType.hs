{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.ResourceType
  ( ResourceType(..)
  , energy
  ) where

import Screeps.Core

newtype ResourceType = ResourceType JSString deriving (JSShow, JSIndex, JSRef, Eq)

foreign import javascript "RESOURCE_ENERGY" energy :: ResourceType
