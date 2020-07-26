{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Objects.Classes
  ( Harvestable(..)
  , HasScreepsId(..)
  , HasOwner(..)
  , Attackable(..)
  , hits
  , hitsMax
  , HasName(..)
  , Transferable(..)
  , Withdrawable(..)
  ) where

import Screeps.Core
import Screeps.Objects.Primitives.ScreepsId
import Screeps.Objects.Primitives.User


class JSRef a => HasScreepsId a where
  sid :: a -> ScreepsId a
  sid = default_sid . toJSRef
foreign import javascript "$1.id" default_sid :: JSVal -> ScreepsId a


class JSRef a => Harvestable a where
  asHarvestable :: a -> JSVal
  asHarvestable = toJSRef


class JSRef a => HasOwner a where
  my :: a -> Bool
  owner :: a -> User
  my = def_my . toJSRef
  owner = def_owner . toJSRef
foreign import javascript "$1.my" def_my :: JSVal -> Bool
foreign import javascript "$1.owner" def_owner :: JSVal -> User


class JSRef a => Attackable a where
  asAttackable :: a -> JSVal
  asAttackable = toJSRef
foreign import javascript "$1.hits" def_hits :: JSVal -> Int
foreign import javascript "$1.hitsMax" def_hits_max :: JSVal -> Int
hits :: Attackable a => a -> Int
hitsMax :: Attackable a => a -> Int
hits = def_hits . asAttackable
hitsMax = def_hits_max . asAttackable


class JSRef a => HasName a where
  name :: a -> JSString
  name = js_name . toJSRef
foreign import javascript "$1.name" js_name :: JSVal -> JSString


class JSRef a => Transferable a where
  asTransferable :: a -> JSVal
  asTransferable = toJSRef


class JSRef a => Withdrawable a where
  asWithdrawable :: a -> JSVal
  asWithdrawable = toJSRef
