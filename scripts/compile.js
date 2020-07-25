require('./utils/preboot.js');
const fs = require('fs');
const path = require('path');
const copy = require('recursive-copy');
const { execSync } = require('child_process');
const glob = require('glob');
const argsParser = require("args-parser");
const {Target, DOCKER_IMAGE} = require('./utils/constants.js');

const args = argsParser(process.argv);
const srcDir = args.src || 'src';
const inputDir = args.input || 'ahc-input';
const outputDir = args.output || 'ahc-output';

const optimizeLevel = process.env.OPTIMIZE === 'true' ? 4 : 0;
const shrinkLevel = process.env.SHRINK === 'true' ? 2 : 0;

const browserFlag = process.env.TARGET === Target.SCREEPS || process.env.TARGET === Target.NODE_SCREEPS ? '--browser' : '';

const dockerCmd = `docker run --rm -v ${path.resolve('build')}:/mirror -w=/mirror ${DOCKER_IMAGE}`;
const ahcLinkCmd = `ahc-link --input-hs=${inputDir}/Main.hs --output-directory=${outputDir} ${browserFlag} --optimize-level=${optimizeLevel} --shrink-level=${shrinkLevel} --ghc-option=-Wall`;

const ahcInputFiles = glob.sync(`build/${inputDir}/**/*.{hs,hi,o,js}`);
const ahcOutputFiles = glob.sync(`build/${outputDir}/**/*.{mjs,wasm,html}`);

Promise.resolve().then(async () => {
  console.log('compiling...');
  ahcInputFiles.forEach(x => fs.unlinkSync(x));
  ahcOutputFiles.forEach(x => fs.unlinkSync(x));
  await copy(srcDir, `build/${inputDir}`, {overwrite: true});
  await fs.promises.mkdir(path.resolve('build', outputDir)).catch(() => null);
  execSync(`${dockerCmd} ${ahcLinkCmd}`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  });
  console.log('compilation is done!')
});
