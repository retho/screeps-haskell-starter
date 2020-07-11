import {loop} from './main.mjs';

const range = (start, end) => new Array(end - start).fill(null).map((_, ix) => start + ix);

const Game = {
  time: 0,
};
global.Game = Game;

console.log(Promise.resolve(1));
console.log((async () => 2)());

range(0, 32).reduce(acc =>
  acc.then(() => {
    Game.time = Game.time + 1;
    return loop();
  })
, Promise.resolve());
