module Screeps.Game
  ( time,
  ) where

foreign import javascript "Game.time" time :: IO Int
