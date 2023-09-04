FROM debian:bullseye

RUN apt update
RUN apt install -y nginx

RUn rm -rf /var/www/html/*

COPY conf/static_page_config /tmp/static_page_config

RUN cat /tmp/static_page_config >> /etc/nginx/http.d/default.conf

COPY conf/index.html /var/www/html/index.html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;"]
