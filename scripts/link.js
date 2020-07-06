const fs = require('fs');
const copy = require('recursive-copy');
const { execSync } = require('child_process');

console.log('linking...');
copy('build/ahc-output', 'build/rollup-input', {overwrite: true})
  .then(() => copy('config/ahc-output-rewrites', 'build/rollup-input', {overwrite: true}))
  .then(() => execSync('npx rollup -c=config/rollup.config.js', {
    stdio: [process.stdin, process.stdout, process.stderr],
  }))
  .then(() => fs.copyFileSync('build/rollup-input/Main.wasm', 'build/dist/compiled.wasm'))
  .then(() => console.log('linking is done!'));
