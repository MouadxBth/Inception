FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt autoremove
RUN apt install -y lsb-release gnupg2 \
    ca-certificates apt-transport-https \
    software-properties-common

RUN add-apt-repository ppa:ondrej/php
RUN apt update -y && apt install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-redis \
    

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
