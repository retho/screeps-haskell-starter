"use strict";

import clear from 'rollup-plugin-clear';
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

export default {
  input: `build/rollup-input/Main.mjs`,
  output: {
    file: "build/dist/main.js",
    format: "iife",
    sourcemap: false
  },
  plugins: [
    clear({ targets: ["build/dist"] }),
    resolve(),
    commonjs(),
    process.env.SHRINK === 'true' && terser(),
  ],
}
