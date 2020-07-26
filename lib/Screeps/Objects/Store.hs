{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Objects.Store
  ( Store(..)
  , HasStore(..)
  , storeCapacity
  , storeFreeCapacity
  , storeUsedCapacity
  ) where

import Screeps.Utils
import Screeps.Core

newtype Store = Store JSObject deriving (JSRef, JSShow)
instance HasStore Store where store = id
instance AsJSHashMap Store ResourceType Int where hashmap = defaultHashmap

class JSRef a => HasStore a where
  store :: a -> Store
  store = default_store . toJSRef

storeCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeCapacity x = get_capacity (store x) . toJSRef

storeFreeCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeFreeCapacity x = get_free_capacity (store x) . toJSRef

storeUsedCapacity :: HasStore a => a -> Maybe ResourceType -> Int
storeUsedCapacity x = get_used_uapacity (store x) . toJSRef

foreign import javascript "$1.store" default_store :: JSVal -> Store
foreign import javascript "$1.getCapacity($2)" get_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getFreeCapacity($2)" get_free_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getUsedCapacity($2)" get_used_uapacity :: Store -> JSVal -> Int
