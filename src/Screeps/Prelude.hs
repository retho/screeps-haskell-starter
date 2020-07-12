{-# LANGUAGE OverloadedStrings #-}

module Screeps.Prelude
  ( JSVal(..)
  , JSString(..)
  , toJSString
  , fromJSString
  , JSShow(..)
  , consoleLog
  ) where

import Asterius.Types (JSVal(..), JSString(..), toJSString, fromJSString)

class JSShow a where
  jsshow :: a -> JSString

foreign import javascript "$1.toString()" jsref_to_string :: JSVal -> JSString
instance JSShow Int where jsshow = toJSString . show
instance JSShow Double where jsshow = toJSString . show
instance JSShow Bool where jsshow = toJSString . show
instance JSShow JSVal where jsshow = jsref_to_string
instance JSShow JSString where jsshow = id

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log

foreign import javascript "$1 + $2" js_concat_str :: JSString -> JSString -> JSString
instance Semigroup JSString where (<>) = js_concat_str
