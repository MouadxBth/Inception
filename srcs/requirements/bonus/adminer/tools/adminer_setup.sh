#!/bin/bash

apt-get install -y wget \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    net-tools && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

mkdir -p /var/www/html

wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php

mv /conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

exec php-fpm${PHP_VERSION} -F