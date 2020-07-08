"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';
const { Env } = require('../utils/constants.js');

export default {
  input: `build/rollup-input/Main.mjs`,
  output: {
    file: "build/dist/main.js",
    format: process.env.ENV === Env.SCREEPS ? "iife" : "cjs",
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    process.env.SHRINK === 'true' && terser(),
  ],
}
