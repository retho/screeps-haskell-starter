#!/usr/bin/env bash

docker build --build-arg force_update=$(date '+%s') -t screeps-docker - < Dockerfile
