#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
chmod +x /usr/local/bin/wp

cd /var/www/wordpress
rm -rf *

wp core download --allow-root

wp config create --allow-root --dbhost=${WORDPRESS_DB_HOST} \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_USER_PASSWORD} \
    --path='/var/www/wordpress'

wp core install --allow-root --url=${DOMAIN_NAME} \
    --title=${WORDPRESS_TITLE} \
    --admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --skip-email

wp user create --allow-root ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
    --user_pass=${WORDPRESS_USER_PASSWORD} \
    --role=author

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf 

mkdir /run/php

exec php-fpm7.4 -F

