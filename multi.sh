#!/bin/sh

docker manifest create 80x86/typecho:latest 80x86/typecho:amd64 80x86/typecho:arm64
docker manifest annotate 80x86/typecho:latest 80x86/typecho:amd64 --os linux --arch amd64
docker manifest annotate 80x86/typecho:latest 80x86/typecho:arm64 --os linux --arch arm64
docker manifest push 80x86/typecho:latest --purge