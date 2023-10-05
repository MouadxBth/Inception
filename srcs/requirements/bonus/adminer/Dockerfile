FROM debian:bullseye

RUN apt-get update -y

COPY /conf/www.conf /conf

COPY tools/adminer_setup.sh /

CMD [ "bash", "adminer_setup.sh"]
