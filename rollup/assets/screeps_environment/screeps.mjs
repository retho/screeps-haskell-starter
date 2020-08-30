import './screeps.env.mjs';

const startsWith = (selfstr, search, rawPos) => {
  var pos = rawPos > 0 ? rawPos|0 : 0;
  return selfstr.substring(pos, pos + search.length) === search;
}

const startedAt = Game.time;
global.wrapHaskellCallback = (cb) => (...args) => {
  const promise = cb(...args)
    .catch(err => {
      if (typeof err === 'string') {
        if (!(startsWith(err, 'ExitSuccess') || startsWith(err, 'ExitFailure '))) {
          console.log(`<span style="color: #ffa07a">Main: ${err}</span>`);
          throw err;
        }
      } else {
        throw err;
      }
    });
  try {
    global.runImmediateQueue();
  } catch (err) {
    const ticksWithoutIncidents = Game.time - startedAt;
    if (ticksWithoutIncidents > 100) Game.cpu.halt();
    throw err;
  }
  return promise;
}
