{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import Asterius.Types (JSString(..), toJSString)

foreign import javascript "Game.any_wrong_field" game_time :: IO Int
foreign import javascript "console.log($1)" console_log :: JSString -> IO ()

main :: IO ()
main = do
  t <- game_time
  console_log $ toJSString $ show t

