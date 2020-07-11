import * as rts from "./rts.mjs";
import mdl from "./Main.wasm.mjs";
import req from "./Main.req.mjs";

process.on('unhandledRejection', up => {
  throw up;
});

module.exports.loopPromise = mdl
  .then(m => rts.newAsteriusInstance(Object.assign(req, {module: m})))
  .then(i => {
    return () => i.exports.main().catch(err => {
      if (typeof err === 'string') {
        if (!(err.startsWith('ExitSuccess') || err.startsWith('ExitFailure '))) {
          i.fs.writeSync(2, `Main: ${err}`);
          throw err;
        }
      } else {
        throw err;
      }
    });
  });
