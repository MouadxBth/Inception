FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt -y install curl php php-fpm php-mysql

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
