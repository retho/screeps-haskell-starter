{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Screeps.Game.CPU
  ( HeapStatistics(..)
  , getHeapStatistics
  , getUsed
  ) where

import Screeps.Prelude

data HeapStatistics
  = HeapStatistics
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

foreign import javascript "Game.cpu.getHeapStatistics()" js_get_heap_statistics :: IO JSVal
getHeapStatistics :: IO (Maybe HeapStatistics)
getHeapStatistics = do
  jsref <- js_get_heap_statistics
  let mjsobj :: Maybe (JSObject Int) = fromNullableJSVal jsref
  pure $ do
    obj <- mjsobj
    pure $ HeapStatistics
      { total_heap_size = unsafeGet obj "total_heap_size"
      , total_heap_size_executable = unsafeGet obj "total_heap_size_executable"
      , total_physical_size = unsafeGet obj "total_physical_size"
      , total_available_size = unsafeGet obj "total_available_size"
      , used_heap_size = unsafeGet obj "used_heap_size"
      , heap_size_limit = unsafeGet obj "heap_size_limit"
      , malloced_memory = unsafeGet obj "malloced_memory"
      , peak_malloced_memory = unsafeGet obj "peak_malloced_memory"
      , does_zap_garbage = unsafeGet obj "does_zap_garbage"
      , externally_allocated_size = unsafeGet obj "externally_allocated_size"
      }

foreign import javascript "Game.cpu.getUsed()" js_get_used :: IO Double
getUsed :: IO Double
getUsed = js_get_used
