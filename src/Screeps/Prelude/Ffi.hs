{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Prelude.Ffi
  ( JSVal(..)
  , JSString(..)
  , JSObj(..)
  , toJSString
  , fromJSString
  , JSIndex(..)
  , JSRef(..)
  , fromNullableJSVal
  , JSHashMap(..)
  , unsafeGet
  , get
  , keys
  , values
  , entries
  ) where

import Asterius.Types (JSVal(..), JSString(..), JSArray(..), toJSString, fromJSString, toJSArray, fromJSArray)
import Data.Coerce (coerce)

newtype JSObj = JSObj JSVal deriving JSRef

instance Semigroup JSString where (<>) = js_concat_str

isUndefined :: JSVal -> Bool
isUndefined = is_null_or_undefined

class JSRef a where
  fromJSVal :: JSVal -> a
  toJSVal :: a -> JSVal

fromNullableJSVal :: JSRef a => JSVal -> Maybe a
fromNullableJSVal val = if isUndefined val then Nothing else Just $ fromJSVal val

class JSIndex a where
  toIndex :: a -> JSString
  fromIndex :: JSString -> a

newtype JSHashMap k v = JSHashMap JSObj deriving JSRef
unsafeGet :: (JSIndex k, JSRef v) => JSHashMap k v -> k -> v
get :: (JSIndex k, JSRef v) => JSHashMap k v -> k -> Maybe v
keys :: (JSIndex k, JSRef v) => JSHashMap k v -> [] k
values :: (JSIndex k, JSRef v) => JSHashMap k v -> [] v
entries :: (JSIndex k, JSRef v) => JSHashMap k v -> [] (k, v)


foreign import javascript "$1..toString()" int_to_index :: Int -> JSString
foreign import javascript "+$1" index_to_int :: JSString -> Int
instance JSIndex Int where
  toIndex = int_to_index
  fromIndex = index_to_int
instance JSIndex JSString where
  toIndex = id
  fromIndex = id

foreign import javascript "$1" jsval_as_int :: JSVal -> Int
foreign import javascript "$1" int_as_jsval :: Int -> JSVal

foreign import javascript "$1" jsval_as_double :: JSVal -> Double
foreign import javascript "$1" double_as_jsval :: Double -> JSVal

foreign import javascript "$1" jsval_as_bool :: JSVal -> Bool
foreign import javascript "$1" bool_as_jsval :: Bool -> JSVal

instance JSRef Int where
  fromJSVal = jsval_as_int
  toJSVal = int_as_jsval
instance JSRef Double where
  fromJSVal = jsval_as_double
  toJSVal = double_as_jsval
instance JSRef Bool where
  fromJSVal = jsval_as_bool
  toJSVal = bool_as_jsval
instance JSRef JSVal where
  fromJSVal = id
  toJSVal = id
instance JSRef JSString where
  fromJSVal = coerce
  toJSVal = coerce
instance JSRef a => JSRef [a] where
  fromJSVal = map fromJSVal . fromJSArray . coerce
  toJSVal = coerce . toJSArray . map toJSVal

foreign import javascript "$1[$2]" js_get :: JSObj -> JSString -> JSVal
unsafeGet (JSHashMap obj) key = fromJSVal $ js_get obj $ toIndex key
get (JSHashMap obj) key = fromNullableJSVal $ js_get obj $ toIndex key

foreign import javascript "Object.keys($1)" js_keys :: JSObj -> JSVal
keys (JSHashMap obj) = map fromIndex $ fromJSVal $ js_keys obj

foreign import javascript "Object.values($1)" js_values :: JSObj -> JSVal
values (JSHashMap obj) = fromJSVal $ js_values obj

entries x = zipWith (\k v -> (k, v)) (keys x) (values x)


foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
