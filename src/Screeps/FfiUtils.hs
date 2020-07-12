
module Screeps.FfiUtils
  ( isNull
  , unsafeGetIndex
  , FromJSVal(..)
  ) where

import Screeps.Prelude

class FromJSVal a where
  fromJSVal :: JSVal -> a

foreign import javascript "$1" as_int :: JSVal -> Int
foreign import javascript "$1" as_double :: JSVal -> Double
foreign import javascript "$1" as_bool :: JSVal -> Bool
foreign import javascript "$1" as_string :: JSVal -> JSString
instance FromJSVal Int where fromJSVal = as_int
instance FromJSVal Double where fromJSVal = as_double
instance FromJSVal Bool where fromJSVal = as_bool
instance FromJSVal JSString where fromJSVal = as_string

foreign import javascript "$1 == null" is_null_or_undefined :: JSVal -> Bool
isNull :: JSVal -> Bool
isNull = is_null_or_undefined

foreign import javascript "$1[$2]" js_get_index :: JSVal -> JSString -> JSVal
unsafeGetIndex :: FromJSVal a => JSVal -> JSString -> a
unsafeGetIndex jsref = fromJSVal . js_get_index jsref
