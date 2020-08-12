module Screeps.Constants.ReturnCode
  ( ReturnCode()
  , ok
  , err_not_owner
  , err_no_path
  , err_name_exists
  , err_busy
  , err_not_found
  , err_not_enough_energy
  , err_not_enough_resources
  , err_invalid_target
  , err_full
  , err_not_in_range
  , err_invalid_args
  , err_tired
  , err_no_bodypart
  , err_not_enough_extensions
  , err_rcl_not_enough
  , err_gcl_not_enough
  ) where

import Screeps.Internal

foreign import javascript "OK" ok :: ReturnCode
foreign import javascript "ERR_NOT_OWNER" err_not_owner :: ReturnCode
foreign import javascript "ERR_NO_PATH" err_no_path :: ReturnCode
foreign import javascript "ERR_NAME_EXISTS" err_name_exists :: ReturnCode
foreign import javascript "ERR_BUSY" err_busy :: ReturnCode
foreign import javascript "ERR_NOT_FOUND" err_not_found :: ReturnCode
foreign import javascript "ERR_NOT_ENOUGH_ENERGY" err_not_enough_energy :: ReturnCode
foreign import javascript "ERR_NOT_ENOUGH_RESOURCES" err_not_enough_resources :: ReturnCode
foreign import javascript "ERR_INVALID_TARGET" err_invalid_target :: ReturnCode
foreign import javascript "ERR_FULL" err_full :: ReturnCode
foreign import javascript "ERR_NOT_IN_RANGE" err_not_in_range :: ReturnCode
foreign import javascript "ERR_INVALID_ARGS" err_invalid_args :: ReturnCode
foreign import javascript "ERR_TIRED" err_tired :: ReturnCode
foreign import javascript "ERR_NO_BODYPART" err_no_bodypart :: ReturnCode
foreign import javascript "ERR_NOT_ENOUGH_EXTENSIONS" err_not_enough_extensions :: ReturnCode
foreign import javascript "ERR_RCL_NOT_ENOUGH" err_rcl_not_enough :: ReturnCode
foreign import javascript "ERR_GCL_NOT_ENOUGH" err_gcl_not_enough :: ReturnCode
