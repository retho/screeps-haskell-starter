import PromisePolyfill from 'promise-polyfill';

PromisePolyfill._immediateFn = global.setImmediate;
PromisePolyfill._unhandledRejectionFn = (up) => {
  throw up;
};

global.Promise = PromisePolyfill;
