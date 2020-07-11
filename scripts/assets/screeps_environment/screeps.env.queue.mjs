const debug = global.debug;

let nextHandle = 1; // Spec says greater than zero
const tasksByHandle = {};

const setImmediateByQueue = (callback, ...args) => {
  debug('setImmediateByQueue', callback);
  const task = { callback: callback, args: args };
  tasksByHandle[nextHandle] = task;
  return nextHandle++;
}

function clearImmediate(handle) {
  debug('clearImmediate', handle);
  delete tasksByHandle[handle];
}

const run = (task) => {
  const callback = task.callback;
  const args = task.args;
  callback(...args);
}

const runImmediateQueue = () => {
  debug('runImmediateQueue', tasksByHandle);

  let handle = Object.keys(tasksByHandle)[0];
  while (handle) {
    const task = tasksByHandle[handle];
    run(task);
    delete tasksByHandle[handle];
    handle = Object.keys(tasksByHandle)[0];
  }
}

const setImmediateByCallImmediately = (callback, ...args) => {
  debug('setImmediateByCallImmediately', callback);
  callback(...args);
}

// * `global.setImmediateByCallImmediately` for Promise polyfill,
// * `global.setImmediate = setImmediateByQueue` for rest (i.e. for Asterius)
global.setTimeout = null;
global.setImmediateByCallImmediately = setImmediateByCallImmediately;
global.setImmediate = setImmediateByQueue;
global.runImmediateQueue = runImmediateQueue;
