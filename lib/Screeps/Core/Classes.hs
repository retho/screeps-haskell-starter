{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Screeps.Core.Classes
  ( ScreepsId(..)
  , User(..)
  , username
  , Harvestable(..)
  , HasScreepsId(..)
  , HasOwner(..)
  , Attackable(..)
  , hits
  , hitsMax
  , HasName(..)
  , Transferable(..)
  , Withdrawable(..)
  , NotifyWhenAttacked(..)
  ) where

import Screeps.Utils
import Screeps.Core.Constants
import Data.String (IsString)


newtype ScreepsId a = ScreepsId JSString deriving (IsString, JSShow, JSIndex, JSRef, Eq)


newtype User = User JSObject deriving (JSRef, JSShow)
username :: User -> JSString
username = js_username . coerce
foreign import javascript "$1.username" js_username :: JSVal -> JSString


class JSRef a => HasScreepsId a where
  sid :: a -> ScreepsId a
  sid = coerce . default_sid . toJSRef
foreign import javascript "$1.id" default_sid :: JSVal -> JSVal


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
hits :: Attackable a => a -> Int
hitsMax :: Attackable a => a -> Int
hits = def_hits . asAttackable
hitsMax = def_hits_max . asAttackable
foreign import javascript "$1.hits" def_hits :: JSVal -> Int
foreign import javascript "$1.hitsMax" def_hits_max :: JSVal -> Int


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


class JSRef a => NotifyWhenAttacked a where
  notifyWhenAttacked :: a -> Bool -> IO ReturnCode
  notifyWhenAttacked self enabled = js_notifyWhenAttacked (toJSRef self) enabled
foreign import javascript "$1.notifyWhenAttacked($2)" js_notifyWhenAttacked :: JSVal -> Bool -> IO ReturnCode
