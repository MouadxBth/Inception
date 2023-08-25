FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y redis

COPY tools/redis_setup.sh /

CMD [ "bash", "redis_setup.sh"]
