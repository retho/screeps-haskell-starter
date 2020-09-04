#!/usr/bin/env bash

if [[ $1 == "install" ]]
then
buildtools/ahc-cabal-update.sh
buildtools/docker-build.sh buildtools/common-scripts/install.sh
elif [[ $1 == "update" ]]
then
buildtools/ahc-cabal-update.sh
elif [[ $1 == "watch" ]]
then
buildtools/docker-dev.sh npm run watch
elif [[ $1 == "check" ]]
then
buildtools/docker-dev.sh npm run check
elif [[ $1 == "check:all" ]]
then
buildtools/docker-dev.sh npm run check:all
elif [[ $1 == "build" ]]
then
buildtools/docker-build.sh npm run build
elif [[ $1 == "deploy" ]]
then
buildtools/docker-build.sh npm run deploy -- --profile=$2
elif [[ $1 == "docker:dev" ]]
then
buildtools/docker-dev.sh
elif [[ $1 == "docker:build" ]]
then
buildtools/docker-build.sh
else
echo "Unknown command: $1" 1>&2
exit 1
fi
