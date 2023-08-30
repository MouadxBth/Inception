FROM debian:bullseye

RUN add-apt-repository ppa:ondrej/php &&\
    apt update -y && \
    apt install -y lsb-release \
        gnupg2 \
        ca-certificates \
        apt-transport-https \
        software-properties-common \
        php${PHP_VERSION} \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-redis &&\
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
