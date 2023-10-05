FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y curl \
    mariadb-client

COPY tools/wordpress_setup.sh /

CMD [ "bash", "/wordpress_setup.sh"]
