FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/wordpress_db_setup.sh /

CMD [ "bash", "/wordpress_db_setup.sh"]