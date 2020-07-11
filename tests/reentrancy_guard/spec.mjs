import {loop} from './main.mjs';

// * error message should not be like: "RuntimeError: ReentrancyGuard: Scheduler reentered!"

const Game = {
  time: 0,
};
global.Game = Game;

loop();
