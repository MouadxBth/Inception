#!/bin/bash

apt install -y curl \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /var/www/html/adminer

curl https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/adminer/index.php

exec php-fpm${PHP_VERSION} -F