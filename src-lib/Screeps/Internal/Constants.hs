module Screeps.Internal.Constants
  ( module Screeps.Internal.Constants
  ) where

import Screeps.Utils

newtype FindConstant a = FindConstant Int deriving (JSShow, JSRef, Eq)
newtype BodyPart = BodyPart JSString deriving (JSShow, JSIndex, JSRef, Eq)
newtype ResourceType = ResourceType JSString deriving (JSShow, JSIndex, JSRef, Eq)
newtype ReturnCode = ReturnCode Int deriving (JSShow, JSIndex, JSRef, Eq)
newtype StructureType = StructureType JSString deriving (JSShow, JSIndex, JSRef, Eq)
