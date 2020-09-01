process.on('unhandledRejection', up => { throw up })
const { execSync } = require('child_process')
const run = (cmd) => execSync(cmd, {stdio: [process.stdin, process.stdout, process.stderr]})

const gcThreshold = 1; // in MBs
const optimizeLevel = 4; // Valid values are 0 to 4
const shrinkLevel = 2; // Valid values are 0 to 2

const builddir = '.cabal-screeps-work/ahc-cabal-build'
const rollupdir = '.cabal-screeps-work/rollup-input'
const distdir = '.cabal-screeps-work/dist'

run(`rm -rf ${rollupdir}`)
run(`rm -rf ${distdir}`)

run(`ahc-cabal v1-install -j --bindir=${rollupdir} --builddir=${builddir}`)
run(`ahc-dist --input-exe=${rollupdir}/main --browser --gc-threshold=${gcThreshold} --optimize-level=${optimizeLevel} --shrink-level=${shrinkLevel}`)

run(`cp -rf rollup/assets/screeps_environment/. ${rollupdir}`)
run(`cp -rf rollup/assets/entry/. ${rollupdir}`)
run('npx rollup -c=rollup/rollup.config.js')
run(`cp ${rollupdir}/main.wasm ${distdir}/compiled.wasm`)
