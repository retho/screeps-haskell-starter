require('./utils/preboot.js');
const path = require('path');
const { execSync } = require('child_process');
const {DOCKER_IMAGE} = require('./utils/constants.js');

execSync(`docker run --rm -it -v ${path.resolve('build')}:/mirror -w=/mirror ${DOCKER_IMAGE}`, {
  stdio: [process.stdin, process.stdout, process.stderr],
});
