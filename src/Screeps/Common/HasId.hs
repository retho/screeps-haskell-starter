{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Common.HasId
  ( ScreepsId(..)
  , HasId(..)
  , defaultSid
  ) where

import Screeps.Core
import Data.String (IsString)


newtype ScreepsId a = ScreepsId JSString deriving (IsString, JSShow, JSIndex, JSRef, Eq)

class JSRef a => HasId a where
  sid :: a -> ScreepsId a

defaultSid :: Coercible a JSObject => a -> ScreepsId a
defaultSid = default_sid . coerce


-- *

foreign import javascript "$1.id" default_sid :: JSObject -> ScreepsId a
