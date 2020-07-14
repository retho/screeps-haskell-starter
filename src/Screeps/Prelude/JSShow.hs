{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Screeps.Prelude.JSShow
  ( JSShow(..)
  ) where

import Screeps.Prelude.Ffi as Ffi

class JSShow a where
  jsshow :: a -> JSString

foreign import javascript "$1.toString()" show_jsref :: JSVal -> JSString
instance JSShow Int where jsshow = toJSString . show
instance JSShow Double where jsshow = toJSString . show
instance JSShow Bool where jsshow = toJSString . show
instance JSShow JSVal where jsshow = show_jsref
instance JSShow JSString where jsshow x = "\"" <> x <> "\""
instance JSShow (JSObject a) where jsshow (JSObject x) = jsshow x
instance JSShow a => JSShow [a] where
  jsshow xs = "[" <> showList xs <> "]"
    where
      showList [] = ""
      showList (x:[]) = jsshow x
      showList (x:xs) = jsshow x <> "," <> showList xs
instance (JSShow a, JSShow b) => JSShow (a, b) where
  jsshow (x, y) = "(" <> jsshow x <> ", " <> jsshow y <> ")"

foreign import javascript "console.log($1)" console_log :: JSString -> IO ()
consoleLog :: JSString -> IO ()
consoleLog = console_log
