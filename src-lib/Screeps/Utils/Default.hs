{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Utils.Default
  ( Default(..)
  ) where

class Default a where
  def :: a
