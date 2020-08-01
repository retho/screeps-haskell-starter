{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.ResourceType
  ( ResourceType()
  , energy
  ) where

import Screeps.Utils
import Screeps.Internal

foreign import javascript "RESOURCE_ENERGY" energy :: ResourceType
