#!/bin/bash

/etc/init.d/mariadb start

mysqladmin -u root password "$MARIADB_ROOT_PASSWORD"

cat << _EOF_ > /tmp/db.sql
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
_EOF_

echo "FIRST:"
mariadb -u root -p"$MARIADB_ROOT_PASSWORD" < /tmp/db.sql

sleep 3

#DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

echo "THIRD:"
mysqladmin -u root -p"$MARIADB_ROOT_PASSWORD" shutdown

exec mysqld
