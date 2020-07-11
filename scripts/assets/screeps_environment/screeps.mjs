import './screeps.env.mjs';
import * as rts from "./rts.mjs";
import mdle from "./Main.wasm.mjs";
import req from "./Main.req.mjs";

const startsWith = (selfstr, search, rawPos) => {
  var pos = rawPos > 0 ? rawPos|0 : 0;
  return selfstr.substring(pos, pos + search.length) === search;
}

export default
  mdle
    .then(m => rts.newAsteriusInstance(Object.assign(req, {module: m})))
    .then(i => {
      return () => {
        return i.exports.main()
          .catch(err => {
            if (typeof err === 'string') {
              if (!(startsWith(err, 'ExitSuccess') || startsWith(err, 'ExitFailure '))) {
                i.fs.writeSync(2, `Main: ${err}`);
                throw err;
              }
            } else {
              throw err;
            }
          });
      };
    });
