#  typecho docker image for amd64/arm64 machine

## both MySQL and SQLite are supported

use [s6](https://skarnet.org/software/s6/why.html) as supervision instead of runit

with slightly modified code which is suitable best for containers: https://github.com/ttys3/typecho/commits/docker

update: typecho code has been updated to [v1.2.1-rc.2](https://github.com/typecho/typecho/releases/tag/v1.2.1-rc.2)

latest image: ` docker.io/80x86/typecho:v1.2.1-rc.2-amd64`


typecho is a PHP based lightweight blog system


### Multi-Architecture image supported

| Architecture | DB Support | Image:Tag                         |
|:-------------|:--------------|:----------------------------------|
| amd64/arm64        | MySQL and SQLite            | 80x86/typecho:latest         |

### container volume map

you need to map container path `/data` to your host machine for persistent data storage.

## example

AMD64 or  arm64:
```shell
docker run -d \
--name=typecho \
--restart always \
--mount type=tmpfs,destination=/tmp \
-v /srv/http/typecho:/data \
-e PHP_TZ=Asia/Shanghai \
-e PHP_MAX_EXECUTION_TIME=600 \
-p 90:80 \
80x86/typecho:latest
```
