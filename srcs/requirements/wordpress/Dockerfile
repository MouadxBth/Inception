FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt -y install curl php php-fpm php-mysql

COPY conf/wordpress_db_setup.sh /

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

WORKDIR /var/www/wordpress

CMD [ "bash", "/wordpress_db_setup.sh"]
