module Logging
  ( setupLogging
  , debug
  , info
  , warn
  , Logging(..)
  ) where

import Screeps.Prelude
import Control.Monad (when)
import qualified Screeps.Game as Game

data Logging = Debug | Info | Warn deriving (Eq, Ord, Enum)

instance JSShow Logging where
  showjs Debug = "[DEBUG]"
  showjs Info = "[INFO]"
  showjs Warn = "[WARN]"

foreign import javascript "global.LOG_LEVEL = $1" set_log_level :: Int -> IO ()
foreign import javascript "global.LOG_LEVEL" get_log_level :: IO JSVal

setupLogging :: Logging -> IO ()
setupLogging = set_log_level . fromEnum

getLogging :: IO Logging
getLogging = get_log_level >>= pure . maybe Info toEnum . fromJSRef

logger :: Logging -> JSString -> IO ()
logger logger_logging msg = do
  current_logging <- getLogging
  when (logger_logging >= current_logging) $ do
    let msg_str = showjs logger_logging <> " " <> msg
    consoleLog msg_str
    when (logger_logging >= Warn) $ Game.notify msg_str

debug :: JSString -> IO ()
info :: JSString -> IO ()
warn :: JSString -> IO ()
debug = logger Debug
info = logger Info
warn = logger Warn
