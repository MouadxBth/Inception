FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y nodejs npm && \
    apt-get autoremove && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/node

RUN npm init -y && npm install express -y

RUN mkdir -p /var/www/node

COPY ./tools /var/www/node/

CMD ["node", "server.js"]
