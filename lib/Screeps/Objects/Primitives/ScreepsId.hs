{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Objects.Primitives.ScreepsId
  ( ScreepsId(..)
  ) where

import Screeps.Core
import Data.String (IsString)

newtype ScreepsId a = ScreepsId JSString deriving (IsString, JSShow, JSIndex, JSRef, Eq)
