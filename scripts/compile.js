const fs = require('fs');
const path = require('path');
const copy = require('recursive-copy');
const { execSync } = require('child_process');
const glob = require('glob');

const optimizeLevel = process.env.OPTIMIZE === 'true' ? 4 : 0;
const shrinkLevel = process.env.SHRINK === 'true' ? 2 : 0;

const dockerCmd = `docker run --rm -v ${path.resolve('build')}:/mirror -w=/mirror terrorjack/asterius:200702`;
const ahcLinkCmd = `ahc-link --input-hs=${'ahc-input'}/Main.hs --output-directory=${'ahc-output'} --yolo --browser --optimize-level=${optimizeLevel} --shrink-level=${shrinkLevel}`;

const oldHsSrcFiles = glob.sync('build/ahc-input/**/*.hs');

oldHsSrcFiles.forEach(x => fs.unlinkSync(x));
copy('src', 'build/ahc-input', {overwrite: true})
  .then(() => fs.promises.mkdir(path.resolve('build', 'ahc-output')).catch(() => null))
  .then(() => execSync(`${dockerCmd} ${ahcLinkCmd}`, {
    stdio: [process.stdin, process.stdout, process.stderr],
  }))
  .then(() => console.log('compilation is done!'));
