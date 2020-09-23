process.on('unhandledRejection', up => { throw up })
const argsParser = require('args-parser');
const { execSync } = require('child_process')
const run = (cmd) => execSync(cmd, {stdio: [process.stdin, process.stdout, process.stderr]})

const args = argsParser(process.argv);
const subname = args['sub'];
const from_scratch = args['from-scratch'];

const builddir_base = '.cabal-screeps-work/ahc-cabal-build';
const builddir = subname ? `${builddir_base}-${subname}` : builddir_base

from_scratch && run(`rm -rf ${builddir}`)
run(`ahc-cabal new-build main -O0 --builddir=${builddir}`)
