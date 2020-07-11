require('./utils/preboot.js');
const fs = require('fs');
const copy = require('recursive-copy');
const {execSync} = require('child_process');
const glob = require('glob');
const {Target} = require('./utils/constants.js');

const rollupInputFiles = glob.sync('build/rollup-input/**/*.{mjs,wasm,html}');
const distFiles = glob.sync('build/dist/**/*.{js,wasm}');

Promise.resolve().then(async () => {
  console.log('linking...');
  rollupInputFiles.forEach(x => fs.unlinkSync(x));
  distFiles.forEach(x => fs.unlinkSync(x));
  await copy('build/ahc-output', 'build/rollup-input', {overwrite: true});

  if (process.env.TARGET === Target.SCREEPS) {
    await copy('scripts/assets/screeps_environment', 'build/rollup-input', {overwrite: true});
    await copy('scripts/assets/target_screeps', 'build/rollup-input', {overwrite: true});
  } else if (process.env.TARGET === Target.NODE_SCREEPS) {
    await copy('scripts/assets/screeps_environment', 'build/rollup-input', {overwrite: true});
    await copy('scripts/assets/target_node-screeps', 'build/rollup-input', {overwrite: true});
  } else if (process.env.TARGET === Target.NODE) {
    await copy('scripts/assets/target_node-native', 'build/rollup-input', {overwrite: true});
  } else {
    throw new Error(`Unknown process.env.TARGET: ${process.env.TARGET}`);
  }

  execSync('npx rollup -c=scripts/rollup/rollup.config.js', {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  fs.copyFileSync('build/rollup-input/Main.wasm', 'build/dist/compiled.wasm');
  console.log('linking is done!');
});
