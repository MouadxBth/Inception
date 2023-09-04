FROM debian:bullseye

RUN apt update -y && \
    apt install -y curl \
    mariadb-client

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
