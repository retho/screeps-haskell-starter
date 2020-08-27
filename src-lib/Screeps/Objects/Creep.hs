module Screeps.Objects.Creep
  ( module SharedCreep
  , Creep()
  , spawning
  , attack
  , attackController
  , build
  , claimController
  , dismantle
  , generateSafeMode
  , getActiveBodyparts
  , harvest
  , heal
  , rangedAttack
  , rangedHeal
  , rangedMassAttack
  , repair
  , reserveController
  , signController
  , upgradeController
  ) where

import Screeps.Utils
import Screeps.Internal

import Screeps.Objects.SharedCreep as SharedCreep


foreign import javascript "$1.spawning" spawning :: Creep -> Bool

attack :: Attackable a => Creep -> a -> IO ReturnCode
attackController :: Creep -> StructureController -> IO ReturnCode
build :: Creep -> ConstructionSite -> IO ReturnCode
claimController :: Creep -> StructureController -> IO ReturnCode
dismantle :: IsStructure a => Creep -> a -> IO ReturnCode
generateSafeMode :: Creep -> StructureController -> IO ReturnCode
getActiveBodyparts :: Creep -> BodyPart -> Int
harvest :: Harvestable a => Creep -> a -> IO ReturnCode
heal :: IsSharedCreep a => Creep -> a -> IO ReturnCode
rangedAttack :: Attackable a => Creep -> a -> IO ReturnCode
rangedHeal :: IsSharedCreep a => Creep -> a -> IO ReturnCode
rangedMassAttack :: Creep -> IO ReturnCode
repair :: IsStructure a => Creep -> a -> IO ReturnCode
reserveController :: Creep -> StructureController -> IO ReturnCode
signController :: Creep -> StructureController -> JSString -> IO ReturnCode
upgradeController :: Creep -> StructureController -> IO ReturnCode


attack self target = js_attack self (asAttackable target)
attackController = js_attackController
build = js_build
claimController = js_claimController
dismantle self target = js_dismantle self (asStructure target)
generateSafeMode = js_generateSafeMode
getActiveBodyparts = js_getActiveBodyparts
harvest self target = js_harvest self (asHarvestable target)
heal self target = js_heal self (asSharedCreep target)
rangedAttack self target = js_rangedAttack self (asAttackable target)
rangedHeal self target = js_rangedHeal self (asSharedCreep target)
rangedMassAttack = js_rangedMassAttack
repair self target = js_repair self (asStructure target)
reserveController = js_reserveController
signController = js_signController
upgradeController = js_upgradeController


foreign import javascript "$1.attack($2)" js_attack :: Creep -> JSVal -> IO ReturnCode
foreign import javascript "$1.attackController($2)" js_attackController :: Creep -> StructureController -> IO ReturnCode
foreign import javascript "$1.build($2)" js_build :: Creep -> ConstructionSite -> IO ReturnCode
foreign import javascript "$1.claimController($2)" js_claimController :: Creep -> StructureController -> IO ReturnCode
foreign import javascript "$1.dismantle($2)" js_dismantle :: Creep -> Structure -> IO ReturnCode
foreign import javascript "$1.generateSafeMode($2)" js_generateSafeMode :: Creep -> StructureController -> IO ReturnCode
foreign import javascript "$1.getActiveBodyparts($2)" js_getActiveBodyparts :: Creep -> BodyPart -> Int
foreign import javascript "$1.harvest($2)" js_harvest :: Creep -> JSVal -> IO ReturnCode
foreign import javascript "$1.heal($2)" js_heal :: Creep -> SharedCreep -> IO ReturnCode
foreign import javascript "$1.rangedAttack($2)" js_rangedAttack :: Creep -> JSVal -> IO ReturnCode
foreign import javascript "$1.rangedHeal($2)" js_rangedHeal :: Creep -> SharedCreep -> IO ReturnCode
foreign import javascript "$1.rangedMassAttack()" js_rangedMassAttack :: Creep -> IO ReturnCode
foreign import javascript "$1.repair($2)" js_repair :: Creep -> Structure -> IO ReturnCode
foreign import javascript "$1.reserveController($2)" js_reserveController :: Creep -> StructureController -> IO ReturnCode
foreign import javascript "$1.signController($2, $3)" js_signController :: Creep -> StructureController -> JSString -> IO ReturnCode
foreign import javascript "$1.upgradeController($2)" js_upgradeController :: Creep -> StructureController -> IO ReturnCode
