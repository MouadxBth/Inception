#!/bin/bash

## install necessary software components for running WordPress
# as well as net-tools for later health-checks
apt-get install -y php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-redis \
    net-tools

## removing unnecessary packages and clearing the package cache
#
# it's a good practice to remove any packages that were automatically installed as
# dependencies but are no longer needed (autoremove), as well as removing
# cached package lists to free up disk space
apt-get autoremove && rm -rf /var/lib/apt/lists/*

## Downloading WP-CLI (WordPress Command-Line Interface)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

## Moving WP-CLI (WordPress Command-Line Interface) to the local binaries folder
mv wp-cli.phar /usr/local/bin/wp

## Setting WP-CLI (WordPress Command-Line Interface) as executable
chmod +x /usr/local/bin/wp

## Changing directory to the mounted wordpress folder
cd /var/www/wordpress

## Preparing the mounted wordpress directory for a fresh installation by removing any 
# existing files and directories
rm -rf *

## Fetching the latest version of WordPress from the official WordPress repository and
# downloading it to the /var/www/wordpress directory using WP-CLI
wp core download --allow-root

## Generating a wp-config.php file with the specified database connection details, such as
# the host, database name, username, and password using WP-CLI.
# This file is essential for WordPress to connect to its database
wp config create --allow-root --dbhost=${WORDPRESS_DB_HOST} \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_USER_PASSWORD} \
    --path='/var/www/wordpress'

## Installing WordPress with the provided configuration settings, including the site URL,
# site title, administrator username, password, and email address using WP-CLI
wp core install --allow-root --url=${DOMAIN_NAME} \
    --title=${WORDPRESS_TITLE} \
    --admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --skip-email

## Adding a user to the WordPress installation with the specified username, email, password,
# and user role using WP-CLI
wp user create --allow-root ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
    --user_pass=${WORDPRESS_USER_PASSWORD} \
    --role=author

## Replacing the listening socket setting in the www.conf pool configuration file
#
# PHP-FPM can communicate with the web server using a Unix socket or a network socket,
# since a Unix socket Unix sockets are used for communication between processes on the same host 
# or operating system, and we need to establish communication between different processes on
# different machines over the network, on a specific port, we replace the Unix socket path with a 
# network socket on port 9000.
# This change indicates that PHP-FPM should listen on port 9000 instead of using a Unix socket
sed -i "s|listen = \/run\/php\/php${PHP_VERSION}-fpm.sock|listen = 9000|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

## Replacing the listening address and port in the main php-fpm.conf configuration file
#
# By default, PHP-FPM listens on 127.0.0.1:9000, which means it accepts connections only from 
# the local machine, and since we need to be able to communicate to other machines on the network 
# on a specific port, we need to modify the setting to listen on all available network 
# interfaces (0.0.0.0) on port 9000, making PHP-FPM accessible from remote hosts
sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

## Creating a directory for PHP-FPM to store its socket file
#
# without manually creating it, php will throw an error:
# ERROR: Unable to create the PID file (/run/php/php7.4-fpm.pid).: No such file or directory
mkdir /run/php

## Setting permissive permissions on the wp-content directory
#
# It grants read, write, and execute permissions to everyone for the wp-content directory,
# to allow WordPress to manage its plugins, themes, and uploads etc..
chmod -R 777 wp-content/

## Configuring the wordpress redis host using WP-CLI
wp config set WP_REDIS_HOST $REDIS_HOST --allow-root

## Configuring the wordpress redis port using WP-CLI
wp config set WP_REDIS_PORT $REDIS_PORT --raw --allow-root

## Configuring the wordpress redis cache key salt using WP-CLI
#
# setting a cache key salt is a good practice to ensure cache key uniqueness, enhance security,
# and prevent cache conflicts when running multiple WordPress websites on the same server or using
# caching mechanisms like Redis
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root

## Installing the redis-cache wordpress plugin using WP-CLI
wp plugin install redis-cache --activate --allow-root

## Updating all wordpress plugins using WP-CLI
wp plugin update --all --allow-root

## Enabling the redis-cache plugin using WP-CLI
wp redis enable --allow-root

## Starting PHP-FPM to handle PHP script execution for the web server, using the -F flag to keep
# the process in the foreground
exec php-fpm${PHP_VERSION} -F

