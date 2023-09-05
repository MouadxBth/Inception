FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y redis && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY tools/redis_setup.sh /

CMD [ "bash", "redis_setup.sh"]
