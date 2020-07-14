{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Prelude.JSShow
  ( JSShow(..)
  ) where

import Screeps.Prelude.Ffi as Ffi
import Data.Coerce (coerce)

class JSShow a where
  jsshow :: a -> JSString

foreign import javascript "$1.toString()" jsobj_to_string :: JSVal -> JSString
foreign import javascript "JSON.stringify($1)" json_stringify :: JSVal -> JSString

instance JSShow Int where jsshow = toJSString . show
instance JSShow Double where jsshow = toJSString . show
instance JSShow Bool where jsshow = toJSString . show
instance JSShow JSString where jsshow = json_stringify . coerce
instance JSShow JSObj where jsshow = jsobj_to_string . coerce
instance JSShow (JSHashMap k v) where jsshow = jsobj_to_string . coerce
instance JSShow a => JSShow [a] where
  jsshow xs = "[" <> showList xs <> "]"
    where
      showList [] = ""
      showList (x:[]) = jsshow x
      showList (x:xs) = jsshow x <> "," <> showList xs
instance (JSShow a, JSShow b) => JSShow (a, b) where
  jsshow (x, y) = "(" <> jsshow x <> ", " <> jsshow y <> ")"
