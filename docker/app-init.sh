#!/bin/sh

. /etc/envvars

ARCH=`uname -m`
CPU_NUM=`nproc --all`
MEM_TOTAL_MB=`free -m | grep Mem | awk '{ print $2 }'`
# Tweak nginx to match the workers to cpu's
#procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $CPU_NUM/" /etc/nginx/nginx.conf

if [ "$PHP_FPM_MAX_CHILDREN" != '' ] && [ "$PHP_FPM_MAX_CHILDREN" != '0' ]; then
    sed -i "s|pm.max_children =.*|pm.max_children = ${PHP_FPM_MAX_CHILDREN}|i" /etc/php7/php-fpm.d/www.conf
fi

#for arm64 soc, limited max_children to CPU num
# if [ "$ARCH" == 'aarch64' ] && [ "$PHP_FPM_MAX_CHILDREN" == '' ]; then
#     sed -i "s|pm.max_children =.*|pm.max_children = ${CPU_NUM}|i" /etc/php7/php-fpm.d/www.conf
# fi

if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php7/php.ini
fi
if [ "$PHP_MAX_EXECUTION_TIME" != '' ]; then
    sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini
    sed -i "s|;*max_input_time =.*|max_input_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini
fi
if [ "$APP_DEBUG" != 'false' ]; then
    sed -i "s|;*php_flag\[display_errors\] =.*|php_flag\[display_errors\] = on|i" /etc/php7/php-fpm.d/www.conf
fi

echo "**** Make sure the /data folders exist ****"
[ ! -d /data/log/nginx ] && \
	mkdir -p /data/log/nginx

[ ! -d /data/log/php7 ] && \
	mkdir -p /data/log/php7

[ ! -L /app/usr ] && \
	cp -ra /app/usr/* /data && \
	rm -r /app/usr && \
	ln -s /data /app/usr && \
	echo "**** Create the symbolic link for the /usr folder ****"

#if app installed, link /data/config.inc.php to /app/config.inc.php
[ ! -L /app/config.inc.php ] && \
[ -e /data/config.inc.php ] && \
	ln -sf /data/config.inc.php /app/config.inc.php && \
	echo "**** Create the symbolic link for config.inc.php ****"

#fixup __TYPECHO_SITE_URL__
if [ -e /data/config.inc.php ] && ! grep -q '__TYPECHO_SITE_URL__' /data/config.inc.php; then
	sed -i "s|define('__TYPECHO_ROOT_DIR__', '/app');.*|define('__TYPECHO_ROOT_DIR__', '/app'); define('__TYPECHO_SITE_URL__', '/');|i" /data/config.inc.php && \
	echo "**** fixup __TYPECHO_SITE_URL__ ****"
fi

echo "**** Set Permissions ****"
chown -R "$HTTPD_USER":"$HTTPD_USER" /data
chmod -R a+rw /data
chown -R "$HTTPD_USER":"$HTTPD_USER" /app

echo "**** Setup complete, starting the server. ****"