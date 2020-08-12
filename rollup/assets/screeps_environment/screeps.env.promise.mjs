import PromisePolyfill from 'promise-polyfill';

PromisePolyfill._immediateFn = global.setImmediateByCallImmediately;
PromisePolyfill._unhandledRejectionFn = (up) => {
  throw up;
};

global.Promise = PromisePolyfill;
