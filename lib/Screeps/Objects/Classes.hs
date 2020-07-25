{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Objects.Classes
  ( Harvestable(..)
  , HasScreepsId(..)
  , defaultSid
  , HasOwner(..)
  , defaultMy
  , defaultOwner
  ) where

import Screeps.Core
import Screeps.Objects.ScreepsId
import Screeps.Objects.User


class JSRef a => HasScreepsId a where
  sid :: a -> ScreepsId a

defaultSid :: Coercible a JSObject => a -> ScreepsId a
defaultSid = default_sid . coerce
foreign import javascript "$1.id" default_sid :: JSObject -> ScreepsId a


class JSRef a => Harvestable a where
  asHarvestable :: a -> JSVal
  asHarvestable = toJSRef


class HasOwner a where
  my :: a -> Bool
  owner :: a -> User

defaultMy :: Coercible a JSVal => a -> Bool
defaultOwner :: Coercible a JSVal => a -> User
defaultMy = def_my . coerce
defaultOwner = def_owner . coerce

foreign import javascript "$1.my" def_my :: JSVal -> Bool
foreign import javascript "$1.owner" def_owner :: JSVal -> User
