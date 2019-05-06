#!/bin/sh

docker manifest create 80x86/lychee:latest 80x86/lychee:AMD64-full-latest 80x86/lychee:arm64-full-latest
docker manifest annotate 80x86/lychee:latest 80x86/lychee:AMD64-full-latest --os linux --arch amd64
docker manifest annotate 80x86/lychee:latest 80x86/lychee:arm64-full-latest --os linux --arch arm64
docker manifest push 80x86/lychee:latest --purge