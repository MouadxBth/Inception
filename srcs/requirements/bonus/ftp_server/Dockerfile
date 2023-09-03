FROM debian:bullseye

RUN echo "${FTP_USER} ${FTP_PASSWORD}"

RUN apt update -y && \
    apt install -y vsftpd && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*


RUN adduser --system \
    --home /var/www/wordpress \
    --shell /bin/false \
    --ingroup root \
    --no-create-home ${FTP_USER}

RUN echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd 

COPY ./tools/ftp_server_setup.sh ./ftp_server_setup.sh 

CMD [ "sh", "./ftp_server_setup.sh" ]
