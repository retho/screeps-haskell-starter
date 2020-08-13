#!/usr/bin/env bash

# double-slash decause of:
# https://stackoverflow.com/questions/50608301/docker-mounted-volume-adds-c-to-end-of-windows-path-when-translating-from-linux
# https://stackoverflow.com/questions/53014998/msys2-and-docker-run-specifying-the-command-looks-for-the-command-locally-befor
docker build -t screeps-docker-env . && docker run --rm -it -v /$(pwd)://project -w=//project screeps-docker-env
