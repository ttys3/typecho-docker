#  typecho blog system docker for amd64/arm64 machine

## both MySQL and SQLite are supported

###  Mod by HuangYeWuDeng(荒野無燈@nanodm.net) for docker

use [s6](https://skarnet.org/software/s6/why.html) as supervision instead of runit

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
--name=typecho-blog \
--restart always \
--mount type=tmpfs,destination=/tmp \
-v /srv/http/typecho:/data \
-e PHP_TZ=Asia/Shanghai \
-e PHP_MAX_EXECUTION_TIME=600 \
-p 90:80 \
80x86/typecho:latest
```