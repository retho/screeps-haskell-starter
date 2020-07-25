{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Core.Ffi
  ( module Coerce
  , JSVal
  , JSString(..)
  , JSObject(..)
  , toJSString
  , fromJSString
  , JSIndex(..)
  , JSRef(..)
  , JSHashMap(..)
  , unsafeGet
  , safeGet
  , keys
  , values
  , entries
  , AsJSHashMap(..)
  , defaultHashmap
  ) where

import Asterius.Types (JSVal, JSString(..), JSArray(..), toJSString, fromJSString, toJSArray, fromJSArray)
import Data.Coerce as Coerce (Coercible, coerce)

newtype JSObject = JSObject JSVal deriving JSRef

instance Semigroup JSString where (<>) = js_concat_str

newtype JSKey = JSKey JSString deriving JSRef

class JSRef a where
  fromJSRef :: JSVal -> a
  toJSRef :: a -> JSVal

class JSIndex a where
  toIndex :: a -> JSKey
  fromIndex :: JSKey -> a

newtype JSHashMap k v = JSHashMap JSObject deriving JSRef
unsafeGet :: (JSIndex k, JSRef v) => k -> JSHashMap k v -> v
safeGet :: (JSIndex k, JSRef v) => k -> JSHashMap k v -> Maybe v
keys :: (JSIndex k, JSRef v) => JSHashMap k v -> [] k
values :: (JSIndex k, JSRef v) => JSHashMap k v -> [] v
entries :: (JSIndex k, JSRef v) => JSHashMap k v -> [] (k, v)

class (JSIndex k, JSRef v) => AsJSHashMap a k v | a -> k v where
  hashmap :: a -> JSHashMap k v

defaultHashmap :: (Coercible a JSObject, JSIndex k, JSRef v) => a -> JSHashMap k v
defaultHashmap = coerce

-- * impl

foreign import javascript "$1..toString()" int_to_index :: Int -> JSKey
foreign import javascript "+$1" index_to_int :: JSKey -> Int
instance JSIndex Int where
  toIndex = int_to_index
  fromIndex = index_to_int
instance JSIndex JSString where
  toIndex = coerce
  fromIndex = coerce

foreign import javascript "undefined" js_null :: JSVal

foreign import javascript "$1" jsval_as_int :: JSVal -> Int
foreign import javascript "$1" int_as_jsval :: Int -> JSVal

foreign import javascript "$1" jsval_as_double :: JSVal -> Double
foreign import javascript "$1" double_as_jsval :: Double -> JSVal

foreign import javascript "$1" jsval_as_bool :: JSVal -> Bool
foreign import javascript "$1" bool_as_jsval :: Bool -> JSVal

instance JSRef Int where
  fromJSRef = jsval_as_int
  toJSRef = int_as_jsval
instance JSRef Double where
  fromJSRef = jsval_as_double
  toJSRef = double_as_jsval
instance JSRef Bool where
  fromJSRef = jsval_as_bool
  toJSRef = bool_as_jsval
instance JSRef JSVal where
  fromJSRef = id
  toJSRef = id
instance JSRef JSString where
  fromJSRef = coerce
  toJSRef = coerce
instance JSRef a => JSRef [a] where
  fromJSRef = map fromJSRef . fromJSArray . coerce
  toJSRef = coerce . toJSArray . map toJSRef
instance JSRef a => JSRef (Maybe a) where
  fromJSRef val
    | is_null_or_undefined val = Nothing
    | otherwise = pure $ fromJSRef val
  toJSRef Nothing = js_null
  toJSRef (Just x) = toJSRef x

foreign import javascript "$1[$2]" js_get :: JSObject -> JSKey -> JSVal
unsafeGet key (JSHashMap obj) = fromJSRef $ js_get obj $ toIndex key
safeGet key (JSHashMap obj) = fromJSRef . js_get obj $ toIndex key

foreign import javascript "Object.keys($1)" js_keys :: JSObject -> JSVal
keys (JSHashMap obj) = map fromIndex . fromJSRef $ js_keys obj

foreign import javascript "Object.values($1)" js_values :: JSObject -> JSVal
values (JSHashMap obj) = fromJSRef $ js_values obj

entries x = zipWith (\k v -> (k, v)) (keys x) (values x)

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
