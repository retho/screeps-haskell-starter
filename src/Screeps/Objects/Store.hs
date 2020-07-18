{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Objects.Store
  ( Store(..)
  , HasStore(..)
  , defaultStore
  , storeCapacity
  , storeFreeCapacity
  , storeUsedCapacity
  ) where

import Screeps.Core
import Screeps.Constants.ResourceType (ResourceType)

newtype Store = Store JSObject deriving (JSRef, JSShow)
instance HasStore Store where store = id
instance AsJSHashMap Store ResourceType Int where hashmap = defaultHashmap

class HasStore a where
  store :: a -> Store

storeCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeCapacity x = get_capacity (store x) . toJSRef

storeFreeCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeFreeCapacity x = get_free_capacity (store x) . toJSRef

storeUsedCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeUsedCapacity x = get_used_uapacity (store x) . toJSRef

defaultStore :: Coercible a JSObject => a -> Store
defaultStore = default_store . coerce

foreign import javascript "$1.store" default_store :: JSObject -> Store
foreign import javascript "$1.getCapacity($2)" get_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getFreeCapacity($2)" get_free_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getUsedCapacity($2)" get_used_uapacity :: Store -> JSVal -> Int
