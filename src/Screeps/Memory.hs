{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Memory
  ( Memory(..)
  , root
  , get
  , set
  , del
  , path
  , keys
  , HasMemory(..)
  ) where

import Screeps.Core hiding (keys)

data Memory = Memory [JSString]

root :: Memory
root = Memory []

get :: JSRef a => JSString -> Memory -> IO (Maybe a)
get key (Memory path) = do
  val <- mem_get $ join path "." <> "." <> key
  pure $ fromJSRef val

set :: JSRef a => JSString -> a -> Memory -> IO ()
set key val (Memory path) = mem_set (join path "." <> "." <> key) $ toJSRef val

del :: Memory -> JSString -> IO ()
del (Memory path) key = mem_del (join path ".") key

path :: Memory -> [JSString] -> Memory
path (Memory init) path = Memory $ init <> path

keys :: Memory -> IO (Maybe [JSString])
keys (Memory path) = mem_keys (join path ".") >>= pure . fromJSRef

class HasMemory a where
  memory :: a -> Memory


join :: [JSString] -> JSString -> JSString
join [] sep = ""
join (x:[]) sep = x
join (x:xs) sep = x <> sep <> join xs sep

foreign import javascript "Object.keys(_.get(global.Memory, $1))" mem_keys :: JSString -> IO JSVal

foreign import javascript "_.get(global.Memory, $1)" mem_get :: JSString -> IO JSVal

foreign import javascript "_.set(global.Memory, $1, $2)" mem_set :: JSString -> JSVal -> IO ()

foreign import javascript "((obj, path, key) => {delete _.get(obj, path)[key];})(global.Memory, $1, $2)" mem_del :: JSString -> JSString -> IO ()

foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
