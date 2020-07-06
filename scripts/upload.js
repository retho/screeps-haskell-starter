const moment = require('moment');
const fs = require('fs');
const fetch = require('node-fetch');
const screepsConfig = require('../screeps.json');

console.log('uploading...');
fetch(`${screepsConfig.screepsHost}/api/user/code`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json; charset=utf-8',
    'X-Token': screepsConfig.auth_token,
  },
  body: JSON.stringify({
    branch: screepsConfig.branch,
    modules: {
      main: fs.readFileSync('build/dist/main.js', 'utf8'),
      compiled: {binary: fs.readFileSync('build/dist/compiled.wasm').toString('base64')},
    },
  }),
})
  .then(res => Promise.all([res.status, res.json()]))
  .then(([status, body]) => console.log(status, body, body.timestamp ? moment(body.timestamp).format('HH:mm') : ''));
