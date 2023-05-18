#thanks https://github.com/dockage/alpine-runit/blob/master/Dockerfile
#thanks https://github.com/faisyl/alpine-runit
#thanks https://github.com/petronetto/php-nginx-alpine
#man https://www.cyberciti.biz/faq/10-alpine-linux-apk-command-examples/

FROM docker.io/80x86/base-alpine:latest

LABEL maintainer='HuangYeWuDeng <***@ttys0.in>' \
        org.label-schema.name="typecho" \
        org.label-schema.vendor="HuangYeWuDeng" \
        org.label-schema.description="Docker image uses s6 as a process supervision run typecho under nginx and php-fpm on Alpine Linux" \
        org.label-schema.vcs-url="https://github.com/ttys3/typecho-docker" \
        org.label-schema.version="1.4" \
        org.label-schema.license="MIT"

# Environment variables
ENV PUID='1001' \
        PGID='1001' \
        HTTPD_USER='www' \
        PHP_TZ=Asia/Shanghai \
        PHP_MAX_EXECUTION_TIME=600 \
        PHP_FPM_MAX_CHILDREN=128 \
        APP_DEBUG=false

# Install packages
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
        && apk --update add --no-cache \
        tzdata \
        nginx \
        curl \
#       ncdu \
        freetype \
        libpng \
        libjpeg-turbo \
        php7 \
        php7-dom \
        php7-fpm \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-exif \
        php7-tokenizer \
        php7-fileinfo \
        php7-xml \
        php7-phar \
        php7-openssl \
        php7-json \
        php7-curl \
        php7-ctype \
        php7-session \
        php7-gd \
        php7-zip \
        php7-zlib \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/share/gtk-doc


# Configuring timezones, see https://wiki.alpinelinux.org/wiki/Setting_the_timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" >  /etc/timezone \
        && apk del --no-cache tzdata \
        && rm -rf /var/cache/apk/*

# Create application folder
# RUN mkdir -p /app

# Add User and Group
#RUN addgroup -g "$PGID" -S "$USER" \
#    && adduser -u "$PUID" -D -S -G "$USER" -h /app -g "$USER" "$USER"

# create www user for php-fpm
RUN addgroup -g 1001 -S $HTTPD_USER \
    && adduser -u 1001 -D -S -G $HTTPD_USER -h /app -g $HTTPD_USER $HTTPD_USER \
    && chown -R nginx:nginx /var/lib/nginx

# copy app build result to image
COPY --chown=1001:1001 typecho /app/

# for debug COPY instruction
# RUN ls -lhp /app/

# Configure Nginx and PHP-FPM
COPY docker/config/ /etc/

# Configure s6 service
COPY docker/services.d /etc/services.d/
RUN chmod +x /etc/services.d/*/run

# inject before run
# ref to https://github.com/dockage/runit-scripts/tree/master/alpine/etc/sv
COPY docker/app-init.sh docker/inject.sh /
RUN chmod +x /app-init.sh \
        && chmod +x /inject.sh

# Setting the workdir
WORKDIR /app

EXPOSE 80
VOLUME /data

HEALTHCHECK --interval=6s --timeout=3s \
  CMD curl -INfs http://localhost/ > /dev/null || exit 1

CMD ["/app-init.sh"]

# vim: set ft=dockerfile ts=4 sw=4 et:
