#!/bin/sh

rm -rf Lychee-Laravel
git clone -b nanodm --recurse-submodules https://github.com/ttys3/Lychee-Laravel.git

# curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/bin --filename=composer \
#     && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
#     && composer config -g -l | grep repositories.packagist.org.url
 cd Lychee-Laravel
 composer install --no-dev --ignore-platform-reqs --no-interaction --prefer-dist
 #find . -type d -name Tests -o -name tests -o -name doc -o -name docs | xargs rm -rf
 cd ..