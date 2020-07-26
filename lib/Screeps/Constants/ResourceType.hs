{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.ResourceType
  ( ResourceType(..)
  , energy
  ) where

import Screeps.Utils

newtype ResourceType = ResourceType JSString deriving (JSShow, JSIndex, JSRef, Eq)

foreign import javascript "RESOURCE_ENERGY" energy :: ResourceType
