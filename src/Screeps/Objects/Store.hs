{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Store
  ( Store(..)
  , getCapacity
  , getFreeCapacity
  , getUsedCapacity
  ) where

import Screeps.Prelude
import Screeps.Constants.Resource (Resource)

newtype Store = Store JSObject deriving (JSRef, JSShow)

instance AsJSHashMap Store Resource Int where hashmap = defaultHashmap

getCapacity :: Store -> Maybe Resource -> Int
getFreeCapacity :: Store -> Maybe Resource -> Int
getUsedCapacity :: Store -> Maybe Resource -> Int

getCapacity x = get_capacity x . toJSVal
getFreeCapacity x = get_free_capacity x . toJSVal
getUsedCapacity x = get_used_uapacity x . toJSVal


-- * ffi

foreign import javascript "$1.getCapacity($2)" get_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getFreeCapacity($2)" get_free_capacity :: Store -> JSVal -> Int
foreign import javascript "$1.getUsedCapacity($2)" get_used_uapacity :: Store -> JSVal -> Int
