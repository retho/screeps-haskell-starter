{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Objects.Room
  ( Room(..)
  , name
  ) where

import Screeps.Core
import Screeps.Constants.FindConstant.Type

newtype Room = Room JSObject deriving (JSRef, JSShow)

foreign import javascript "name" name :: Room -> JSString

find :: JSRef a => FindConstant a -> [a]
find = fromJSRef . raw_find

foreign import javascript "$1.find($2)" raw_find :: FindConstant a -> JSVal
