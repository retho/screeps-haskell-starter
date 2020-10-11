import './screeps.env.mjs';
import './screeps.utils.mjs';

const startedAt = Game.time;
let haltRequired = false;
global.wrapHaskellCallback = (cb) => (...args) => {
  try {
    const promise = cb(...args);
    global.runImmediateQueue();
    return promise;
  } catch (err) {
    const msg = 'panic: ' + err.toString()
    console.log(`<span style="color: #ffa07a">${msg}</span>`);
    if (!haltRequired) Game.notify(msg)
    haltRequired = true;
    throw err;
  } finally {
    if (haltRequired && Game.time - startedAt > 100) Game.cpu.halt();
  }
}
