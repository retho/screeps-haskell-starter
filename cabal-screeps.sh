#!/usr/bin/env bash

if [[ $1 == "install" ]]
then
buildtools/docker.sh shell-scripts/install.sh
elif [[ $1 == "update" ]]
then
buildtools/ahc-cabal-update.sh
elif [[ $1 == "watch" ]]
then
buildtools/docker.sh npm run watch
elif [[ $1 == "check" ]]
then
buildtools/docker.sh npm run check
elif [[ $1 == "check:all" ]]
then
buildtools/docker.sh npm run check:all
elif [[ $1 == "build" ]]
then
buildtools/docker.sh npm run build
elif [[ $1 == "deploy" ]]
then
buildtools/docker.sh npm run deploy
elif [[ $1 == "docker" ]]
then
buildtools/docker.sh
else
echo "Unknown command: $1" 1>&2
exit 1
fi
