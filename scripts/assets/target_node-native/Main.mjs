import * as rts from "./rts.mjs";
import mdl from "./Main.wasm.mjs";
import req from "./Main.req.mjs";

module.exports.loopPromise = mdl
  .then(m => rts.newAsteriusInstance(Object.assign(req, {module: m})))
  .then(i => {
    return () => i.exports.main().catch(err => {if (!(err.startsWith('ExitSuccess') || err.startsWith('ExitFailure '))) i.fs.writeSync(2, `Main: ${err}`)});
  });
