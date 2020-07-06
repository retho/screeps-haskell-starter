import './polyfill.mjs';
import * as rts from "./rts.mjs";
import m from "./Main.wasm.mjs";
import req from "./Main.req.mjs";

const i = rts.newAsteriusInstance(Object.assign(req, {module: m}));

module.exports.loop = i.exports.main;
