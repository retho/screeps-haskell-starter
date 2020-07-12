{-# LANGUAGE OverloadedStrings #-}

module Screeps.Game.CPU
  ( HeapStatistics(..)
  , getHeapStatistics
  , getUsed
  ) where

import Screeps.Prelude
import Screeps.FfiUtils

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
  pure $
    if isNull jsref
    then Nothing
    else Just $ HeapStatistics
      { total_heap_size = unsafeGetIndex jsref "total_heap_size"
      , total_heap_size_executable = unsafeGetIndex jsref "total_heap_size_executable"
      , total_physical_size = unsafeGetIndex jsref "total_physical_size"
      , total_available_size = unsafeGetIndex jsref "total_available_size"
      , used_heap_size = unsafeGetIndex jsref "used_heap_size"
      , heap_size_limit = unsafeGetIndex jsref "heap_size_limit"
      , malloced_memory = unsafeGetIndex jsref "malloced_memory"
      , peak_malloced_memory = unsafeGetIndex jsref "peak_malloced_memory"
      , does_zap_garbage = unsafeGetIndex jsref "does_zap_garbage"
      , externally_allocated_size = unsafeGetIndex jsref "externally_allocated_size"
      }

foreign import javascript "Game.cpu.getUsed()" js_get_used :: IO Double
getUsed :: IO Double
getUsed = js_get_used
