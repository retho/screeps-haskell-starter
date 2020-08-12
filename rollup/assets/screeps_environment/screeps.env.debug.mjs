
global.debug = (...args) => {
  if (global.DEBUG_SCREEPS_ENV) console.log(...args);
}
