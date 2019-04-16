#/bin/sh

sudo docker run --rm --privileged multiarch/qemu-user-static:register --reset

echo "begin build gd version ..."
git checkout master
sudo docker image rm -f 80x86/lychee:AMD64-latest
sudo docker image prune -f
sudo docker build -f ./docker/Dockerfile -t 80x86/lychee:AMD64-latest .
sudo docker push 80x86/lychee:AMD64-latest

git checkout arm64
sudo docker image rm -f 80x86/lychee:arm64-latest
sudo docker image prune -f
sudo docker build -f ./docker/Dockerfile -t 80x86/lychee:arm64-latest .
sudo docker push 80x86/lychee:arm64-latest
echo "end build gd version ..."

echo "begin build imagick version ..."
git checkout imagick
sudo docker image rm -f 80x86/lychee:AMD64-imagick-latest
sudo docker image prune -f
sudo docker build -f ./docker/Dockerfile -t 80x86/lychee:AMD64-imagick-latest .
sudo docker push 80x86/lychee:AMD64-imagick-latest

git checkout arm64-imagick
sudo docker image rm -f 80x86/lychee:arm64-imagick-latest
sudo docker image prune -f
sudo docker build -f ./docker/Dockerfile -t 80x86/lychee:arm64-imagick-latest .
sudo docker push 80x86/lychee:arm64-imagick-latest
echo "end build imagick version ..."