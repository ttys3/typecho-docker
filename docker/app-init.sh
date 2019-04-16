#!/bin/sh

. /etc/envvars

# Tweak nginx to match the workers to cpu's
procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

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

[ ! -e /tmp/first_run ] && \
	echo "**** Generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	cd /app/Lychee-Laravel && \
	./artisan key:generate && \
	echo "**** Migrate the database ****" && \
	cd /app/Lychee-Laravel && \
	./artisan migrate && \
	touch /tmp/first_run

echo "**** Set Permissions ****" && \
chown -R "$HTTPD_USER":"$HTTPD_USER" /conf
chown -R "$HTTPD_USER":"$HTTPD_USER" /uploads
chmod -R a+rw /uploads
chown -R "$HTTPD_USER":"$HTTPD_USER" /app/Lychee-Laravel

echo "**** Setup complete, starting the server. ****"