FROM debian:bullseye

RUN apt update -y && \
    apt install -y vsftpd && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/ftp_server_setup.sh ./ftp_server_setup.sh 

CMD [ "sh", "./ftp_server_setup.sh" ]
