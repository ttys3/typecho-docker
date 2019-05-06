#/bin/sh

docker run --rm --privileged multiarch/qemu-user-static:register --reset

git checkout master

echo "begin build full version ..."
docker image rm -f 80x86/lychee:AMD64-full-latest
docker image rm -f registry.cn-shenzhen.aliyuncs.com/ttys0/docker-lychee-alpine-s6:AMD64-full-latest
docker image prune -f
docker build -f ./docker/Dockerfile -t 80x86/lychee:AMD64-full-latest .
docker push 80x86/lychee:AMD64-full-latest
docker push registry.cn-shenzhen.aliyuncs.com/ttys0/docker-lychee-alpine-s6:AMD64-full-latest

docker image rm -f 80x86/lychee:arm64-full-latest
docker image rm -f registry.cn-shenzhen.aliyuncs.com/ttys0/docker-lychee-alpine-s6:arm64-full-latest
docker image prune -f
docker build -f ./docker/Dockerfile.arm64 -t 80x86/lychee:arm64-full-latest .
docker push 80x86/lychee:arm64-full-latest
docker push registry.cn-shenzhen.aliyuncs.com/ttys0/docker-lychee-alpine-s6:arm64-full-latest
echo "end build full version ..."

./multi.sh