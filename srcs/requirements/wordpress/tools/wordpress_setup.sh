#!/bin/bash

apt install -y php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-redis \
    net-tools

apt autoremove && rm -rf /var/lib/apt/lists/*

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

sed -i "s|listen = \/run\/php\/php${PHP_VERSION}-fpm.sock|listen = 9000|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

mkdir /run/php

chmod -R 0777 wp-content/

wp config set WP_REDIS_HOST $REDIS_HOST --allow-root
wp config set WP_REDIS_PORT $REDIS_PORT --raw --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root


wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

exec php-fpm${PHP_VERSION} -F

