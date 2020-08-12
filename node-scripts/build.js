process.on('unhandledRejection', up => { throw up })
const { execSync } = require('child_process')
const run = (cmd) => execSync(cmd, {stdio: [process.stdin, process.stdout, process.stderr]})

const optimizeLevel = 4; // Valid values are 0 to 4
const shrinkLevel = 2; // Valid values are 0 to 2

run('rm -rf build-screeps')
run(`ahc-cabal v1-install -j --bindir=build-screeps/rollup-input --builddir=ahc-cabal-build`)
run(`ahc-dist --input-exe=build-screeps/rollup-input/main --browser --optimize-level=${optimizeLevel} --shrink-level=${shrinkLevel}`)

run('cp -rf rollup/assets/screeps_environment/. build-screeps/rollup-input/')
run('cp -rf rollup/assets/entry/. build-screeps/rollup-input/')
run('npx rollup -c=rollup/rollup.config.js')
run('cp build-screeps/rollup-input/main.wasm build-screeps/dist/compiled.wasm')
