#!/bin/sh

docker manifest create 80x86/lychee:latest 80x86/lychee:AMD64-latest 80x86/lychee:arm64-latest
docker manifest annotate 80x86/lychee:latest 80x86/lychee:AMD64-latest --os linux --arch amd64
docker manifest annotate 80x86/lychee:latest 80x86/lychee:arm64-latest --os linux --arch arm64
docker manifest push 80x86/lychee:latest --purge

docker manifest create 80x86/lychee:imagick-latest 80x86/lychee:AMD64-imagick-latest 80x86/lychee:arm64-imagick-latest
docker manifest annotate 80x86/lychee:imagick-latest 80x86/lychee:AMD64-imagick-latest --os linux --arch amd64
docker manifest annotate 80x86/lychee:imagick-latest 80x86/lychee:arm64-imagick-latest --os linux --arch arm64
docker manifest push 80x86/lychee:imagick-latest --purge

