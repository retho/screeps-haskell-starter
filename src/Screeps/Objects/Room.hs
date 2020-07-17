{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Room
  ( Room(..)
  , name
  ) where

import Screeps.Core
import Screeps.Memory
import Screeps.Constants.FindConstant.Type

newtype Room = Room JSObject deriving (JSRef, JSShow)
instance HasMemory Room where memory x = Memory ["rooms", name x]

foreign import javascript "$1.name" name :: Room -> JSString

find :: JSRef a => FindConstant a -> [a]
find = fromJSRef . raw_find . toJSRef

foreign import javascript "$1.find($2)" raw_find :: JSVal -> JSVal
