FROM debian:bullseye

RUN apt update -y && \
    apt install -y vsftpd && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ftpmbouthai -d /var/www/html -M --password 123456 

COPY ./tools/ftp_server_setup.sh ./ftp_server_setup.sh 

CMD [ "sh", "./ftp_server_setup.sh" ]
