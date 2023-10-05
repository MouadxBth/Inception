FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y vsftpd && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/ftp_server_setup.sh ./ftp_server_setup.sh 

CMD [ "sh", "./ftp_server_setup.sh" ]
