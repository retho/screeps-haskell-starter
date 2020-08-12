module Screeps.Objects.Room
  ( Room()
  , find
  , controller
  ) where

import Screeps.Utils
import Screeps.Internal


find :: JSRef a => FindConstant a -> Room -> IO [a]
find x rm = raw_find rm (toJSRef x) >>= pure . fromJSRef

controller :: Room -> Maybe StructureController
controller = fromJSRef . raw_controller

foreign import javascript "$1.controller" raw_controller :: Room -> JSVal

-- *

foreign import javascript "$1.find($2)" raw_find :: Room -> JSVal -> IO JSVal
