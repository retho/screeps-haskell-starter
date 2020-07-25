
module Screeps.Objects.Classes
  ( Harvestable(..)
  ) where

import Screeps.Core

class JSRef a => Harvestable a where
  asHarvestable :: a -> JSVal
  asHarvestable = toJSRef
