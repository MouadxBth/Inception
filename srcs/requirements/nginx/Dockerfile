FROM debian:bullseye

RUN apt update -y && \
    apt install -y openssl nginx &&\
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl /var/www/wordpress \
    && chmod 755 /var/www/wordpress \
    && chown -R www-data:www-data /var/www/wordpress

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MA/ST=Casablanca/L=Settat/O=42/OU=42/CN=mbouthai.42.fr/UID=mbouthai"

COPY conf/default /etc/nginx/sites-enabled/default

EXPOSE 3306

CMD [ "nginx", "-g", "daemon off;"]