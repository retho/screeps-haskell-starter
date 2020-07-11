require('./utils/preboot.js');
const fs = require('fs');
const {execSync} = require('child_process');
const {Target} = require('./utils/constants.js');
const argsParser = require('args-parser');

const args = argsParser(process.argv);
const testSuite = args.suite;

if (![Target.NODE_SCREEPS, Target.NODE].includes(process.env.TARGET)) {
  throw new Error(`Cannot run test suite for TARGET=${process.env.TARGET}`);
}

Promise.resolve().then(async () => {
  execSync(`node scripts/compile.js --src=${testSuite}`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  execSync(`node scripts/link.js`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  fs.copyFileSync(`${testSuite}/spec.js`, 'build/dist/spec.js');
  console.log('Running test...\n\n\n');
  execSync(`node spec.js`, {
    stdio: [process.stdin, process.stdout, process.stderr],
    cwd: 'build/dist',
  });
});
