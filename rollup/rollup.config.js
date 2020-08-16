"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

export default {
  input: `.cabal-screeps-work/rollup-input/main.mjs`,
  output: {
    file: ".cabal-screeps-work/dist/main.js",
    format: "iife",
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    false && terser(),
  ],
}
