#!/bin/bash

wp core download --allow-root

wp config create --allow-root --dbhost=${DB_HOST} \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_USER_PASSWORD} \
    --path='/var/www/wordpress'

wp core install --allow-root --url=${DOMAIN_NAME} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN} \
	--admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email

wp user create --allow-root ${WP_USER} ${WP_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author