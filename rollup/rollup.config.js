"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

const rollupdir = '.cabal-screeps-work/rollup-input'
const distdir = '.dist'

export default {
  input: `${rollupdir}/main.mjs`,
  output: {
    file: `${distdir}/main.js`,
    format: 'iife',
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    false && terser(),
  ],
}
