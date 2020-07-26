{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Screeps.Objects.Room
  ( module Room
  , find
  , controller
  ) where

import Screeps.Utils
import Screeps.Core

import Screeps.Objects.Core.Room as Room
import Screeps.Objects.Structure.StructureController


find :: JSRef a => FindConstant a -> Room -> IO [a]
find x rm = raw_find rm (toJSRef x) >>= pure . fromJSRef

controller :: Room -> Maybe StructureController
controller = fromJSRef . raw_controller

foreign import javascript "$1.controller" raw_controller :: Room -> JSVal

-- *

foreign import javascript "$1.find($2)" raw_find :: Room -> JSVal -> IO JSVal
