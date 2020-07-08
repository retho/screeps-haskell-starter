


# Scripts

`npm start` show compilation error on changes in `src/*`

`npm run deploy` compiles and uploads the code to the server (based on settings in `screeps.json`)

`npm run test:<env-name> -- --suite=<suite-name>` runs test suite within environment `<env-name>`, where `<suite-name>` is name of folder within `/tests`
- `npm run test:node-screeps -- --suite=...` must work as well as `npm run test:node-native -- --suite=...` (this check may be useful when updating docker image `terrorjack/asterius:<version>`)
