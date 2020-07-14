{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Prelude.Ffi
  ( module Asterius
  , isUndefined
  , JSRef(..)
  , fromNullableJSVal
  , JSObject(..)
  , unsafeGet
  , get
  , keys
  , values
  , entries
  ) where

import Asterius.Types as Asterius (JSVal(..), JSString(..), JSArray(..), toJSString, fromJSString, toJSArray, fromJSArray)

foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
isUndefined :: JSVal -> Bool
isUndefined = is_null_or_undefined

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
instance Semigroup JSString where (<>) = js_concat_str

foreign import javascript "$1" jsval_as_int :: JSVal -> Int
foreign import javascript "$1" int_as_jsval :: Int -> JSVal

foreign import javascript "$1" jsval_as_double :: JSVal -> Double
foreign import javascript "$1" double_as_jsval :: Double -> JSVal

foreign import javascript "$1" jsval_as_bool :: JSVal -> Bool
foreign import javascript "$1" bool_as_jsval :: Bool -> JSVal

foreign import javascript "$1" jsval_as_jsstring :: JSVal -> JSString
foreign import javascript "$1" jsstring_as_jsval :: JSString -> JSVal

foreign import javascript "$1" jsval_as_jsarr :: JSVal -> JSArray
foreign import javascript "$1" jsarr_as_jsval :: JSArray -> JSVal

class JSRef a where
  fromJSVal :: JSVal -> a
  toJSVal :: a -> JSVal

instance JSRef Int where
  fromJSVal = jsval_as_int
  toJSVal = int_as_jsval
instance JSRef Double where
  fromJSVal = jsval_as_double
  toJSVal = double_as_jsval
instance JSRef Bool where
  fromJSVal = jsval_as_bool
  toJSVal = bool_as_jsval
instance JSRef JSString where
  fromJSVal = jsval_as_jsstring
  toJSVal = jsstring_as_jsval
instance JSRef JSArray where
  fromJSVal = jsval_as_jsarr
  toJSVal = jsarr_as_jsval
instance JSRef JSVal where
  fromJSVal = id
  toJSVal = id
instance JSRef a => JSRef [a] where
  fromJSVal = map fromJSVal . fromJSArray . fromJSVal
  toJSVal = toJSVal . toJSArray . map toJSVal


fromNullableJSVal :: JSRef a => JSVal -> Maybe a
fromNullableJSVal val = if isUndefined val then Nothing else Just $ fromJSVal val

newtype JSObject a = JSObject JSVal deriving JSRef
unsafeGet :: JSRef a => JSObject a -> JSString -> a
get :: JSRef a => JSObject a -> JSString -> Maybe a
keys :: JSRef a => JSObject a -> [] JSString
values :: JSRef a => JSObject a -> [] a
entries :: JSRef a => JSObject a -> [] (JSString, a)

foreign import javascript "$1[$2]" js_get :: JSVal -> JSString -> JSVal
unsafeGet (JSObject jsref) key = fromJSVal $ js_get jsref key
get (JSObject jsref) key = fromNullableJSVal $ js_get jsref key

foreign import javascript "Object.keys($1)" js_keys :: JSVal -> JSVal
keys (JSObject jsref) = fromJSVal $ js_keys jsref

foreign import javascript "Object.values($1)" js_values :: JSVal -> JSVal
values (JSObject jsref) = fromJSVal $ js_values jsref

entries x = zipWith (\x y -> (x, y)) (keys x) (values x)

