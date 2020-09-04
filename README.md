
# screeps-haskell-starter

Haskell build tools for [Screeps](https://screeps.com/) based on [Asterius](https://github.com/tweag/asterius) compiler.



# Quickstart

[Docker](https://www.docker.com/get-started) must be installed and running.

```bash
# clone:
git clone https://github.com/retho/screeps-haskell-starter.git
cd screeps-haskell-starter

# cli dependencies:
./cabal-screeps.sh install

# configure for uploading:
cp screeps.example.json screeps.json
nano screeps.json

# compile and upload:
./cabal-screeps.sh deploy
```



# Scripts

- `./cabal-screeps.sh update` updates ahc-cabal's package list
- `./cabal-screeps.sh watch` checks if it compiles on changes in src/
- `./cabal-screeps.sh check` checks if it compiles
- `./cabal-screeps.sh check:all` checks if it compiles and shows all warnings
- `./cabal-screeps.sh build` builds it, puts files in .dist/ in project root
- `./cabal-screeps.sh deploy` builds and uploads it to the server (based on settings in `screeps.json`)
