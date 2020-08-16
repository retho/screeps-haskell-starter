process.on('unhandledRejection', up => { throw up })
const { execSync } = require('child_process')
const run = (cmd) => execSync(cmd, {stdio: [process.stdin, process.stdout, process.stderr]})

const optimizeLevel = 4; // Valid values are 0 to 4
const shrinkLevel = 2; // Valid values are 0 to 2

run('rm -rf .cabal-screeps-work/rollup-input')
run('rm -rf .cabal-screeps-work/dist')

run(`ahc-cabal v1-install -j --bindir=.cabal-screeps-work/rollup-input --builddir=.cabal-screeps-work/ahc-cabal-build`)
run(`ahc-dist --input-exe=.cabal-screeps-work/rollup-input/main --browser --optimize-level=${optimizeLevel} --shrink-level=${shrinkLevel}`)

run('cp -rf rollup/assets/screeps_environment/. .cabal-screeps-work/rollup-input/')
run('cp -rf rollup/assets/entry/. .cabal-screeps-work/rollup-input/')
run('npx rollup -c=rollup/rollup.config.js')
run('cp .cabal-screeps-work/rollup-input/main.wasm .cabal-screeps-work/dist/compiled.wasm')
