import './screeps.env.mjs';
import './screeps.utils.mjs';

const startsWith = (selfstr, search, rawPos) => {
  const pos = rawPos > 0 ? rawPos|0 : 0;
  return selfstr.substring(pos, pos + search.length) === search;
}

const startedAt = Game.time;
let haltRequired = false;
global.wrapHaskellCallback = (cb) => (...args) => {
  try {
    const promise = cb(...args);
    global.runImmediateQueue();
    return promise;
  } catch (err) {
    if (typeof err === 'string' && (!(startsWith(err, 'ExitSuccess') || startsWith(err, 'ExitFailure ')))) {
      console.log(`<span style="color: #ffa07a">Main: ${err}</span>`);
    }
    haltRequired = true;
    Game.cpu.halt();
    throw err;
  } finally {
    if (haltRequired && Game.time - startedAt > 100) Game.cpu.halt();
  }
}
