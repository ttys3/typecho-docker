#/bin/sh

docker run --rm --privileged multiarch/qemu-user-static:register --reset

echo "begin build full version ..."
docker image rm -f 80x86/typecho:amd64
docker image rm -f registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:amd64
docker image prune -f
docker build -f ./docker/Dockerfile -t 80x86/typecho:amd64 .
docker push 80x86/typecho:amd64
docker tag 80x86/typecho:amd64 registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:amd64
docker push registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:amd64

docker image rm -f 80x86/typecho:arm64
docker image rm -f registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:arm64
docker image prune -f
docker build -f ./docker/Dockerfile.arm64 -t 80x86/typecho:arm64 .
docker push 80x86/typecho:arm64
docker tag 80x86/typecho:arm64 registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:arm64
docker push registry.cn-shenzhen.aliyuncs.com/ttys0/docker-typecho-alpine-s6:arm64
echo "end build full version ..."

./multi.sh