const {loopPromise} = require('./main.js');

const range = (start, end) => new Array(end - start).fill(null).map((_, ix) => start + ix);

const Game = {
  time: 0,
};
global.Game = Game;

loopPromise.then(loop => {
  return range(0, 32).reduce(acc =>
    acc.then(() => {
      Game.time = Game.time + 1;
      return loop();
    })
  , Promise.resolve());
});
