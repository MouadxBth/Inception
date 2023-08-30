FROM debian:bullseye

RUN apt update -y && \
    apt install -y curl \
    php \
    php-fpm \
    php-mysql \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-redis &&\
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
