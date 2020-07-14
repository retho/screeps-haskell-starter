"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';
const { Target } = require('../utils/constants.js');

export default {
  input: `build/rollup-input/Main.mjs`,
  output: {
    file: process.env.TARGET === Target.SCREEPS ? "build/dist/main.js" : "build/dist/main.mjs",
    format: process.env.TARGET === Target.SCREEPS ? "iife" : "es",
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    false && process.env.SHRINK === 'true' && terser(),
  ],
}
