{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Screeps.Game.CPU
  ( HeapStatistics(..)
  , getHeapStatistics
  , getUsed
  ) where

import Screeps.Core

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
  let mjsobj :: Maybe (JSHashMap JSString Int) = fromJSRef jsref
  pure $ do
    obj <- mjsobj
    pure $ HeapStatistics
      { total_heap_size = unsafeGet "total_heap_size" obj
      , total_heap_size_executable = unsafeGet "total_heap_size_executable" obj
      , total_physical_size = unsafeGet "total_physical_size" obj
      , total_available_size = unsafeGet "total_available_size" obj
      , used_heap_size = unsafeGet "used_heap_size" obj
      , heap_size_limit = unsafeGet "heap_size_limit" obj
      , malloced_memory = unsafeGet "malloced_memory" obj
      , peak_malloced_memory = unsafeGet "peak_malloced_memory" obj
      , does_zap_garbage = unsafeGet "does_zap_garbage" obj
      , externally_allocated_size = unsafeGet "externally_allocated_size" obj
      }

foreign import javascript "Game.cpu.getUsed()" js_get_used :: IO Double
getUsed :: IO Double
getUsed = js_get_used
