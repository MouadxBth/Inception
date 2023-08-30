FROM debian:bullseye

RUN apt update
RUN apt install -y nginx

RUn rm -rf /var/www/html/*

RUN echo "server {" > /etc/nginx/http.d/default.conf && \
    echo "root    /var/www/html;" >> /etc/nginx/http.d/default.conf && \
    echo "location / {" >> /etc/nginx/http.d/default.conf && \
    echo "    try_files \$uri /index.html;" >> /etc/nginx/http.d/default.conf && \
    echo "}\n}" >> /etc/nginx/http.d/default.conf

COPY conf/index.html /var/www/html/index.html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;"]
