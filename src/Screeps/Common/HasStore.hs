{-# LANGUAGE FlexibleContexts #-}

module Screeps.Common.HasStore
  ( HasStore(..)
  , defaultStore
  , storeCapacity
  , storeFreeCapacity
  , storeUsedCapacity
  ) where

import Screeps.Core
import Screeps.Objects.Store
import Screeps.Constants.Resource

class HasStore a where
  store :: a -> Store

storeCapacity :: HasStore a => a -> Maybe Resource -> Int
storeCapacity = getCapacity . store

storeFreeCapacity :: HasStore a => a -> Maybe Resource -> Int
storeFreeCapacity = getFreeCapacity . store

storeUsedCapacity :: HasStore a => a -> Maybe Resource -> Int
storeUsedCapacity = getUsedCapacity . store

defaultStore :: Coercible a JSObject => a -> Store
defaultStore = default_store . coerce

foreign import javascript "$1.store" default_store :: JSObject -> Store
