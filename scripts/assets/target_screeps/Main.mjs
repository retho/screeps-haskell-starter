import loopPromise from './screeps.mjs';

loopPromise.then(loop => {
  module.exports.loop = loop;
});
