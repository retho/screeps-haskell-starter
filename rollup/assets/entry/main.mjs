import './screeps.mjs';
import * as rts from "./rts.mjs";
import mdle from "./main.wasm.mjs";
import req from "./main.req.mjs";

mdle
  .then(m => rts.newAsteriusInstance(Object.assign(req, {module: m})))
  .then(i => global.wrapHaskellCallback(i.exports.main))
  .then(main => main());
