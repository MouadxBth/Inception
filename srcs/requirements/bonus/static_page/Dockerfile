FROM debian:bullseye

RUN apt update -y && \
    apt install -y nodejs npm && \
    apt autoremove && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/node

COPY ./tools /var/www/node/

WORKDIR /var/www/node

RUN npm init -y && npm install express -y

CMD ["node", "server.js"]
