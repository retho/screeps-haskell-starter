process.on('unhandledRejection', up => { throw up })
const argsParser = require('args-parser');
const { execSync } = require('child_process')
const run = (cmd) => execSync(cmd, {stdio: [process.stdin, process.stdout, process.stderr]})

const args = argsParser(process.argv);
const profile = args['profile'];
const from_scratch = args['from-scratch'];

const builddir_base = '.cabal-screeps-work/ahc-cabal-build';
const builddir = profile ? `${builddir_base}-${profile}` : builddir_base

from_scratch && run(`rm -rf ${builddir}`)
run(`ahc-cabal new-build main -O0 --builddir=${builddir}`)
