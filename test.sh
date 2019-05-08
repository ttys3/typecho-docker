#!/bin/sh

git checkout master

docker image rm -f 80x86/typecho:amd64
docker image prune -f
docker build -f ./docker/Dockerfile -t 80x86/typecho:amd64 .

./run.sh


