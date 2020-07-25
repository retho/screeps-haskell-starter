{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Constants.Core.FindConstant
  ( FindConstant(..)
  ) where

import Screeps.Core

newtype FindConstant a = FindConstant Int deriving (JSShow, JSRef, Eq)
