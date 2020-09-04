process.on('unhandledRejection', up => { throw up })
const moment = require('moment');
const fs = require('fs');
const argsParser = require('args-parser');
const fetch = require('node-fetch');

const screepsConfig = require(process.env.PWD + '/screeps.json');
const args = argsParser(process.argv);
const profileName = args['profile'] || screepsConfig.default_profile
const profile = screepsConfig.profiles[profileName];

if (!profile) throw new Error('Unknown profile name: ' + profileName)

const distdir = '.dist';

console.log('uploading...');
fetch(`${profile.screeps_host}/api/user/code`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json; charset=utf-8',
    'X-Token': profile.auth_token,
  },
  body: JSON.stringify({
    branch: profile.branch,
    modules: {
      main: fs.readFileSync(`${distdir}/main.js`, 'utf8'),
      compiled: {binary: fs.readFileSync(`${distdir}/compiled.wasm`).toString('base64')},
    },
  }),
})
  .then(res => Promise.all([res.status, res.json()]))
  .then(([status, body]) => console.log(status, body, body.timestamp ? moment(body.timestamp).format() : ''));
