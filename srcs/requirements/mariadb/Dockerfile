FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/wordpress_db_setup.sh /

CMD [ "bash", "/wordpress_db_setup.sh"]