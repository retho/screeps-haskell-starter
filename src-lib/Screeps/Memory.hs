module Screeps.Memory
  ( Memory(..)
  , root
  , get
  , set
  , unset
  , path
  , keys
  , HasMemory(..)
  ) where

import Screeps.Utils hiding (keys)
import Screeps.Internal

data Memory = Memory [JSString]

root :: Memory
root = Memory []

get :: JSRef a => JSString -> Memory -> IO (Maybe a)
get key (Memory mem_path) = do
  val <- mem_get $ join mem_path "." <> "." <> key
  pure $ fromJSRef val

set :: JSRef a => JSString -> a -> Memory -> IO ()
set key val (Memory mem_path) = mem_set (join mem_path "." <> "." <> key) $ toJSRef val

unset :: Memory -> IO ()
unset (Memory mem_path) = mem_unset $ join mem_path "."

path :: Memory -> [JSString] -> Memory
path (Memory init_path) extra_path = Memory $ init_path <> extra_path

keys :: Memory -> IO (Maybe [JSString])
keys (Memory mem_path) = mem_keys (join mem_path ".") >>= pure . fromJSRef

class HasMemory a where
  memory :: a -> Memory

instance HasMemory Room where memory x = Memory ["rooms", name x]
instance HasMemory Creep where memory x = Memory ["creeps", name x]
instance HasMemory PowerCreep where memory x = Memory ["powerCreeps", name x]



--
join :: [JSString] -> JSString -> JSString
join [] _ = ""
join (x:[]) _ = x
join (x:xs) sep = x <> sep <> join xs sep

foreign import javascript "Object.keys(_.get(Memory, $1))" mem_keys :: JSString -> IO JSVal

foreign import javascript "_.get(Memory, $1)" mem_get :: JSString -> IO JSVal

foreign import javascript "_.set(Memory, $1, $2)" mem_set :: JSString -> JSVal -> IO ()

foreign import javascript "lodash_es.unset(Memory, $1)" mem_unset :: JSString -> IO ()
