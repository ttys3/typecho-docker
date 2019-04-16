#/bin/sh

docker run --rm --privileged multiarch/qemu-user-static:register --reset

git checkout master

echo "begin build gd version ..."
docker image rm -f 80x86/lychee:AMD64-latest
docker image prune -f
docker build -f ./docker/Dockerfile -t 80x86/lychee:AMD64-latest .
docker push 80x86/lychee:AMD64-latest

docker image rm -f 80x86/lychee:arm64-latest
docker image prune -f
docker build -f ./docker/Dockerfile.arm64 -t 80x86/lychee:arm64-latest .
docker push 80x86/lychee:arm64-latest
echo "end build gd version ..."

echo "begin build imagick version ..."
docker image rm -f 80x86/lychee:AMD64-imagick-latest
docker image prune -f
docker build -f ./docker/Dockerfile.imagick -t 80x86/lychee:AMD64-imagick-latest .
docker push 80x86/lychee:AMD64-imagick-latest

docker image rm -f 80x86/lychee:arm64-imagick-latest
docker image prune -f
docker build -f ./docker/Dockerfile.arm64.imagick -t 80x86/lychee:arm64-imagick-latest .
docker push 80x86/lychee:arm64-imagick-latest
echo "end build imagick version ..."

./multi.sh