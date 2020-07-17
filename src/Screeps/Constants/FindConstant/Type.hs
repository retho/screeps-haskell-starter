{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.FindConstant.Type
  ( FindConstant(..)
  ) where

import Screeps.Core

newtype FindConstant a = FindConstant Int deriving (JSShow, JSRef, Eq)
