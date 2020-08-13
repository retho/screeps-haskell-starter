"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

export default {
  input: `build-screeps/rollup-input/main.mjs`,
  output: {
    file: "build-screeps/dist/main.js",
    format: "iife",
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    false && terser(),
  ],
}
