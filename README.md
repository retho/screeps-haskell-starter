
# screeps-haskell-starter

Haskell build tools for [Screeps](https://screeps.com/) based on [Asterius](https://github.com/tweag/asterius) compiler.



# Quickstart

[Docker](https://www.docker.com/get-started) must be installed and running.

```bash
# clone:
git clone https://github.com/retho/screeps-haskell-starter.git
cd screeps-haskell-starter

# cli dependencies:
./run.sh update
./run.sh install

# configure for uploading:
cp screeps.example.json screeps.json
nano screeps.json

# compile and upload:
./run.sh deploy
```



# Scripts

- `./run.sh update` updates ahc-cabal's package list
- `./run.sh watch` checks if it compiles on changes in src/
- `./run.sh check` checks if it compiles
- `./run.sh check:all` checks if it compiles and shows all warnings
- `./run.sh build` builds it, puts files in .dist/ in project root
- `./run.sh deploy [profile]` builds and uploads it to the server (based on settings in `screeps.json`)
