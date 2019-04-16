#!/bin/sh

git checkout master

docker image rm -f 80x86/lychee:AMD64-latest
docker image prune -f
docker build -f ./docker/Dockerfile -t 80x86/lychee:AMD64-latest .

./run.sh


