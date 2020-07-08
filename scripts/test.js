require('./utils/preboot.js');
const fs = require('fs');
const {execSync} = require('child_process');
const {Env} = require('./utils/constants.js');
const argsParser = require('args-parser');

const args = argsParser(process.argv);
const testSuite = args.suite;

if (![Env.NODE_SCREEPS, Env.NODE_NATIVE].includes(process.env.ENV)) {
  throw new Error(`Cannot run test suite within ENV=${process.env.ENV}`);
}

Promise.resolve().then(async () => {
  execSync(`node scripts/compile.js --src=tests/${testSuite}`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  execSync(`node scripts/link.js`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  fs.copyFileSync(`tests/${testSuite}/spec.js`, 'build/dist/spec.js');
  console.log('Running test...\n\n\n');
  execSync(`node spec.js`, {
    stdio: [process.stdin, process.stdout, process.stderr],
    cwd: 'build/dist',
  });
});
