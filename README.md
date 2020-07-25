
# screeps-haskell-starter

Haskell build tools for [Screeps](https://screeps.com/) based on [Asterius](https://github.com/tweag/asterius) compiler.



# Quickstart

[Node](https://nodejs.org/en/) and [Docker](https://www.docker.com/get-started) must be installed. Docker must be running.

```bash
# clone:
git clone https://github.com/retho/screeps-haskell-starter.git
cd screeps-haskell-starter

# cli dependencies:
npm install

# configure for uploading:
cp screeps.example.json screeps.json
nano screeps.json

# compile and upload:
npm run deploy
```



# Scripts

`npm start` shows compilation errors on changes in `src/*`

`npm run deploy` compiles and uploads the code to the server (based on settings in `screeps.json`)

`npm run test:<target-name> -- --suite=<suite-path>` runs test suite within environment `<target-name>`, where `<suite-path>` is path to folder with test, e.g. `--suite=tests/basic`
  + `npm run test:node-screeps -- --suite=<suite-path>` must work as well as `npm run test:node -- --suite=<suite-path>`
  + requires Node >= v14.5.0



# Scripts Environment Variables

- `TARGET=screeps|node-screeps|node`
  + `screeps` - builds for screeps server
  + `node-screeps` - builds for node with screeps environment (synchronous setImmediate and polyfills)
  + `node` - builds for node native environment
- `OPTIMIZE=true`
- `SHRINK=true`



# Known Issues

- errors like in `tests/reentrancy_guard` are not displayed within [Simulation](https://screeps.com/a/#!/sim),
- the error `RuntimeError: ReentrancyGuard: GC reentered!` occurs after a while running the script
