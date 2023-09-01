FROM debian:bullseye

RUN apt update -y && \
    apt install -y vsftpd && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --system \
    --home /var/www/wordpress \
    --shell /sbin/nologin \
    --ingroup root \
    --no-create-home \
    ftpmbouthai

COPY ./tools/ftp_server_setup.sh ./ftp_server_setup.sh 

CMD [ "sh", "./ftp_server_setup.sh" ]
