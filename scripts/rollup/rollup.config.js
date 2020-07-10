"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';
const { Target } = require('../utils/constants.js');

export default {
  input: `build/rollup-input/Main.mjs`,
  output: {
    file: "build/dist/main.js",
    format: process.env.TARGET === Target.SCREEPS ? "iife" : "cjs", // * "cjs" doesn't work in simulation
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    process.env.SHRINK === 'true' && terser(),
  ],
}
