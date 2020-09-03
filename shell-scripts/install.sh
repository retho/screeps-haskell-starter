#!/usr/bin/env bash

hpack_version=0.34.2

npm install
cabal v2-update && cabal v2-install hpack -j --constraint="hpack == $hpack_version" --installdir=/workspace/.bin --install-method=copy
