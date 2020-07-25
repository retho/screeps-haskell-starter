{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Core.JSShow
  ( JSShow(..)
  ) where

import Screeps.Core.Ffi as Ffi

class JSShow a where
  showjs :: a -> JSString

foreign import javascript "$1.toString()" show_jsobj :: JSVal -> JSString
foreign import javascript "JSON.stringify($1)" json_stringify :: JSVal -> JSString

instance JSShow Int where showjs = json_stringify . toJSRef
instance JSShow Double where showjs = json_stringify . toJSRef
instance JSShow Bool where
  showjs True = "True"
  showjs False = "False"
instance JSShow JSString where showjs = json_stringify . coerce
instance JSShow JSObject where showjs = show_jsobj . coerce
instance JSShow (JSHashMap k v) where showjs = show_jsobj . coerce
instance JSShow a => JSShow [a] where
  showjs xs = "[" <> showjsList xs <> "]"
    where
      showjsList [] = ""
      showjsList (y:[]) = showjs y
      showjsList (y:ys) = showjs y <> "," <> showjsList ys
instance (JSShow a, JSShow b) => JSShow (a, b) where
  showjs (x, y) = "(" <> showjs x <> ", " <> showjs y <> ")"
