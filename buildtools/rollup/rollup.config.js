"use strict";

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import cleanup from 'rollup-plugin-cleanup';
import { terser } from 'rollup-plugin-terser';

const rollupinputdir = '.cabal-screeps-work/rollup-input'
const distdir = '.dist'

export default {
  input: `${rollupinputdir}/main.mjs`,
  output: {
    file: `${distdir}/main.js`,
    format: 'iife',
    sourcemap: false
  },
  plugins: [
    resolve(),
    commonjs(),
    false && cleanup(),
    false && terser(),
  ],
}
