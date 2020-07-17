{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Screeps.Memory
  ( Memory(..)
  , root
  , get
  , set
  , keys
  , HasMemory(..)
  ) where

import Screeps.Core hiding (keys)

data Memory = Memory [JSString]

newtype MemoryReference = MemoryReference JSObject deriving JSRef

root :: Memory
root = Memory []

get :: JSRef a => JSString -> Memory -> IO (Maybe a)
get key (Memory path) = do
  maybe_mem_ref <- get_last_ref path root_mem_ref
  case maybe_mem_ref of
    Nothing -> pure Nothing
    Just mem_ref -> mem_get mem_ref key >>= pure . fromJSRef

set :: JSRef a => JSString -> a -> Memory -> IO ()
set key val (Memory path) = do
  mem_ref <- create_path_to_last_ref path root_mem_ref
  mem_set mem_ref key (toJSRef val)

path :: Memory -> [JSString] -> Memory
path (Memory init) path = Memory $ init <> path

keys :: Memory -> IO (Maybe [JSString])
keys (Memory path) = do
  maybe_mem_ref <- get_last_ref path root_mem_ref
  case maybe_mem_ref of
    Nothing -> pure Nothing
    Just mem_ref -> mem_ref_keys mem_ref >>= pure . fromJSRef

class HasMemory a where
  memory :: a -> Memory


get_last_ref :: [JSString] -> MemoryReference -> IO (Maybe MemoryReference)
get_last_ref [] ref = pure $ pure ref
get_last_ref (p:ps) ref = do
  next_ref <- mem_get ref p
  if is_null_or_undefined next_ref then pure Nothing else get_last_ref ps $ fromJSRef next_ref

create_path_to_last_ref :: [JSString] -> MemoryReference -> IO MemoryReference
create_path_to_last_ref [] ref = pure ref
create_path_to_last_ref (p:ps) ref = do
  next_ref <- mem_get ref p
  if is_null_or_undefined next_ref then new_ref >>= create_path_to_last_ref ps else create_path_to_last_ref ps $ fromJSRef next_ref


foreign import javascript "global.Memory" root_mem_ref :: MemoryReference

foreign import javascript "$1[$2]" mem_get :: MemoryReference -> JSString -> IO JSVal

foreign import javascript "$1[$2] = $3" mem_set :: MemoryReference -> JSString -> JSVal -> IO ()

foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool

foreign import javascript "{}" new_ref :: IO MemoryReference

foreign import javascript "Object.keys($1)" mem_ref_keys :: MemoryReference -> IO JSVal
