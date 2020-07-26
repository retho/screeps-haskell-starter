{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Core.Default
  ( Default(..)
  ) where

class Default a where
  def :: a
