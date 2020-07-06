import SyncPromise from './polyfill.SyncPromise.mjs';
global.Promise = SyncPromise;
global.setTimeout = f => f();
global.setImmediate = f => f();
