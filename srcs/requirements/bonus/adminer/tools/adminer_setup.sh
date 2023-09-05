#!/bin/bash

apt install -y curl \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql

mkdir -p /var/www/html

curl https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/index.php

adduser -u 82 -D -S -G www-data www-data

COPY /conf/www.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

exec php-fpm${PHP_VERSION} -F