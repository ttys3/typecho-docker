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
if [ "$ARCH" == 'aarch64' ] && [ "$PHP_FPM_MAX_CHILDREN" == '0' ]; then
    sed -i "s|pm.max_children =.*|pm.max_children = ${CPU_NUM}|i" /etc/php7/php-fpm.d/www.conf
fi

if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php7/php.ini
fi
if [ "$PHP_MAX_EXECUTION_TIME" != '' ]; then
    sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini
    sed -i "s|;*max_input_time =.*|max_input_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini
fi

echo "**** Make sure the /conf and /uploads folders exist ****"
[ ! -f /conf ] && \
	mkdir -p /conf
[ ! -f /uploads ] && \
	mkdir -p /uploads

[ ! -f /uploads/small ] && mkdir -p /uploads/small
[ ! -f /uploads/medium ] && mkdir -p /uploads/medium
[ ! -f /uploads/big ] && mkdir -p /uploads/big
[ ! -f /uploads/thumb ] && mkdir -p /uploads/thumb
[ ! -f /uploads/import ] && mkdir -p /uploads/import

echo "**** Create the symbolic link for the /uploads folder ****"
[ ! -L /app/Lychee-Laravel/public/uploads ] && \
	cp -r /app/Lychee-Laravel/public/uploads/* /uploads && \
	rm -r /app/Lychee-Laravel/public/uploads && \
	ln -s /uploads /app/Lychee-Laravel/public/uploads

echo "**** Copy the .env to /conf ****" && \
[ ! -e /conf/.env ] && \
	cp /app/Lychee-Laravel/.env.example /conf/.env
[ ! -L /app/Lychee-Laravel/.env ] && \
	ln -s /conf/.env /app/Lychee-Laravel/.env
echo "**** Inject .env values ****" && \
	/inject.sh

[ ! -e /etc/app-init-done ] && \
	echo "**** Generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	cd /app/Lychee-Laravel && \
	./artisan key:generate && \
	echo "**** Migrate the database ****" && \
	cd /app/Lychee-Laravel && \
	./artisan migrate && \
	touch /etc/app-init-done

echo "**** Set Permissions ****" && \
chown -R "$HTTPD_USER":"$HTTPD_USER" /conf
chown -R "$HTTPD_USER":"$HTTPD_USER" /uploads
chmod -R a+rw /uploads
chown -R "$HTTPD_USER":"$HTTPD_USER" /app/Lychee-Laravel

echo "**** Setup complete, starting the server. ****"