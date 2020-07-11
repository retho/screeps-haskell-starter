
global.debug = (...args) => {
  if (!!global.DEBUG) console.log(...args);
}
