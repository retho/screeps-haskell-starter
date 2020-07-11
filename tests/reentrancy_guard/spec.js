const {loopPromise} = require('./main.js');

// * error message should not be like: "RuntimeError: ReentrancyGuard: Scheduler reentered!"

const Game = {
  time: 0,
};
global.Game = Game;

loopPromise.then(loop => {
  return loop();
});
