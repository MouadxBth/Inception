#!/bin/bash

mysql_secure_installation << _EOF_
$MARIADB_ROOT_PASSWORD
n
n
y
n
y
y
_EOF_

if [ ! -d "/var/run/mysqld" ]; then
	mkdir -p /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld
fi

# Create SQL script
cat << _EOF_ > /tmp/db.sql
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
_EOF_

mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown

exec mysqld_safe

