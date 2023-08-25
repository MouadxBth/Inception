FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt -y install curl php php-fpm php-mysql mariadb-client

COPY tools/wordpress_setup.sh /

EXPOSE 9000

CMD [ "bash", "/wordpress_setup.sh"]
