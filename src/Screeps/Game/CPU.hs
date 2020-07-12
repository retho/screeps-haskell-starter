{-# LANGUAGE OverloadedStrings #-}

module Screeps.Game.CPU
  ( HeapStatistics(..)
  , getHeapStatistics
  , getUsed
  ) where

import Asterius.Types (JSVal (..), JSString(..))

foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
foreign import javascript "$1[$2]" unsafe_get_field_int :: JSVal -> JSString -> Int

foreign import javascript "Game.cpu.getHeapStatistics()" js_get_heap_statistics :: IO JSVal
foreign import javascript "Game.cpu.getUsed()" js_get_used :: IO Float

data HeapStatistics =
  HeapStatistics
    { total_heap_size :: Int
    , total_heap_size_executable :: Int
    , total_physical_size :: Int
    , total_available_size :: Int
    , used_heap_size :: Int
    , heap_size_limit :: Int
    , malloced_memory :: Int
    , peak_malloced_memory :: Int
    , does_zap_garbage :: Int
    , externally_allocated_size :: Int
    }

getHeapStatistics :: IO (Maybe HeapStatistics)
getHeapStatistics = do
  jsref <- js_get_heap_statistics
  pure $
    if is_null_or_undefined jsref
    then Nothing
    else Just $ HeapStatistics
      { total_heap_size = unsafe_get_field_int jsref "total_heap_size"
      , total_heap_size_executable = unsafe_get_field_int jsref "total_heap_size_executable"
      , total_physical_size = unsafe_get_field_int jsref "total_physical_size"
      , total_available_size = unsafe_get_field_int jsref "total_available_size"
      , used_heap_size = unsafe_get_field_int jsref "used_heap_size"
      , heap_size_limit = unsafe_get_field_int jsref "heap_size_limit"
      , malloced_memory = unsafe_get_field_int jsref "malloced_memory"
      , peak_malloced_memory = unsafe_get_field_int jsref "peak_malloced_memory"
      , does_zap_garbage = unsafe_get_field_int jsref "does_zap_garbage"
      , externally_allocated_size = unsafe_get_field_int jsref "externally_allocated_size"
      }

getUsed :: IO Float
getUsed = js_get_used
