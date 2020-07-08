const {loopPromise} = require('./main.js');

loopPromise.then(loop => {
  return loop();
});
