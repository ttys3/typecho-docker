# Lychee album with SQLite support 

## No MySQL needed!

###  Mod by HuangYeWuDeng(荒野無燈@nanodm.net)

use [s6](https://skarnet.org/software/s6/why.html) as supervision instead of runit

Lychee is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.


![lychee-icon](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/lychee-icon.png)

### Multi-Architecture image supported

| Architecture | Image Handler | Image:Tag                         |
|:-------------|:--------------|:----------------------------------|
| AMD64/arm64        | GD            | 80x86/lychee:latest         |
| AMD64/arm64        | Imagick       | 80x86/lychee:imagick-latest |

### Architecture specific image
| Architecture | Image Handler | Image:Tag                         |
|:-------------|:--------------|:----------------------------------|
| AMD64        | GD            | 80x86/lychee:AMD64-latest         |
| AMD64        | Imagick       | 80x86/lychee:AMD64-imagick-latest |
| arm64        | GD            | 80x86/lychee:arm64-latest         |
| arm64        | Imagick       | 80x86/lychee:arm64-imagick-latest |

------------------------------------------------------------


## example

AMD64 or  arm64:
```shell
docker run -d \
--name=lychee-laravel \
--restart always \
-v /srv/http/lychee-laravel/conf:/conf \
-v /srv/http/lychee-laravel/uploads:/uploads \
-e PHP_TZ=Asia/Shanghai \
-e PHP_MAX_EXECUTION_TIME=600 \
-e DB_CONNECTION=sqlite \
-e DB_DATABASE=/conf/lychee.db \
-p 90:80 \
80x86/lychee:latest
```