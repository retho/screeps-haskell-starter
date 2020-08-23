
# screeps-haskell-starter

Haskell build tools for [Screeps](https://screeps.com/) based on [Asterius](https://github.com/tweag/asterius) compiler.



# Quickstart

[Docker](https://www.docker.com/get-started) must be installed and running.

```bash
# clone:
git clone https://github.com/retho/screeps-haskell-starter.git
cd screeps-haskell-starter

# enter to docker container
./start.sh

# cli dependencies:
shell-scripts/install.sh

# configure for uploading:
cp screeps.example.json screeps.json
nano screeps.json

# compile and upload:
npm run deploy
```



# Scripts

This scripts should be running inside docker container (enter to container via `./start.sh`).

- `npm run check` checks if it compiles
- `npm run check:all` checks if it compiles and shows all warnings
- `npm run deploy` compiles and uploads it to the server (based on settings in `screeps.json`)


# Known Issues

May not work in Simulation.
