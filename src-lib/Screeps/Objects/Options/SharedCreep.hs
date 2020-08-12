module Screeps.Objects.Options.SharedCreep
  ( MoveToOptions(..)
  ) where

import Screeps.Utils

data MoveToOptions =
  MoveToOptions
    { _reusePath :: Int
    , _serializeMemory :: Bool
    , _noPathFinding :: Bool
    }

instance Default MoveToOptions where
  def =
    MoveToOptions
      { _reusePath = 5
      , _serializeMemory = True
      , _noPathFinding = False
      }

instance JSRef MoveToOptions where
  toJSRef opts =
    coerce $ fromEntries [("reusePath" :: JSString, toJSRef $ _reusePath opts), ("serializeMemory", toJSRef $ _serializeMemory opts), ("noPathFinding", toJSRef $ _noPathFinding opts)]
  fromJSRef ref =
    MoveToOptions
      { _reusePath = fromJSRef . unsafeGet ("reusePath" :: JSString) . coerce $ ref
      , _serializeMemory = fromJSRef . unsafeGet ("serializeMemory" :: JSString) . coerce $ ref
      , _noPathFinding = fromJSRef . unsafeGet ("noPathFinding" :: JSString) . coerce $ ref
      }


