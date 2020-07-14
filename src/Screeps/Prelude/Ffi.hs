{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Prelude.Ffi
  ( JSVal(..)
  , JSString(..)
  , JSObject(..)
  , toJSString
  , fromJSString
  , JSIndex(..)
  , JSRef(..)
  , JSHashMap(..)
  , unsafeGet
  , get
  , keys
  , values
  , entries
  , AsJSHashMap(..)
  , defaultHashmap
  ) where

import Asterius.Types (JSVal(..), JSString(..), JSArray(..), toJSString, fromJSString, toJSArray, fromJSArray)
import Data.Coerce (Coercible, coerce)

newtype JSObject = JSObject JSVal deriving JSRef

instance Semigroup JSString where (<>) = js_concat_str

class JSRef a where
  fromJSVal :: JSVal -> a
  toJSVal :: a -> JSVal

class JSIndex a where
  toIndex :: a -> JSString
  fromIndex :: JSString -> a

newtype JSHashMap k v = JSHashMap JSObject deriving JSRef
unsafeGet :: (JSIndex k, JSRef v) => k -> JSHashMap k v -> v
get :: (JSIndex k, JSRef v) => k -> JSHashMap k v -> Maybe v
keys :: (JSIndex k, JSRef v) => JSHashMap k v -> [] k
values :: (JSIndex k, JSRef v) => JSHashMap k v -> [] v
entries :: (JSIndex k, JSRef v) => JSHashMap k v -> [] (k, v)

class (JSIndex k, JSRef v) => AsJSHashMap a k v | a -> k v where
  hashmap :: a -> JSHashMap k v

defaultHashmap :: (Coercible a JSObject, JSIndex k, JSRef v) => a -> JSHashMap k v
defaultHashmap = coerce

-- * impl

foreign import javascript "$1..toString()" int_to_index :: Int -> JSString
foreign import javascript "+$1" index_to_int :: JSString -> Int
instance JSIndex Int where
  toIndex = int_to_index
  fromIndex = index_to_int
instance JSIndex JSString where
  toIndex = id
  fromIndex = id

foreign import javascript "undefined" js_null :: JSVal

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
instance JSRef a => JSRef (Maybe a) where
  fromJSVal val
    | is_null_or_undefined val = Nothing
    | otherwise = pure $ fromJSVal val
  toJSVal Nothing = js_null
  toJSVal (Just x) = toJSVal x

foreign import javascript "$1[$2]" js_get :: JSObject -> JSString -> JSVal
unsafeGet key (JSHashMap obj) = fromJSVal $ js_get obj $ toIndex key
get key (JSHashMap obj) = fromJSVal . js_get obj $ toIndex key

foreign import javascript "Object.keys($1)" js_keys :: JSObject -> JSVal
keys (JSHashMap obj) = map fromIndex $ fromJSVal $ js_keys obj

foreign import javascript "Object.values($1)" js_values :: JSObject -> JSVal
values (JSHashMap obj) = fromJSVal $ js_values obj

entries x = zipWith (\k v -> (k, v)) (keys x) (values x)


foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
