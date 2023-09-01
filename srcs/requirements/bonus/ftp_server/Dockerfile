FROM debian:bullseye

RUN apt update -y && \
    apt install -y vsftpd \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --system \
    --home /var/www/wordpress \
    --shell /sbin/nologin \
    --ingroup root \
    --no-create-home \
    ftpmbouthai

RUN chmod -R 750 /var/www/wordpress && \
    chown -R ftpmbouthai:ftpmbouthai  /var/www/wordpress && \
    echo "ftpmbouthai" >> /etc/vsftpd.userlist && \
    echo "ftpmbouthai:123456" | /usr/sbin/chpasswd && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "chroot_local_user=YES" >> /etc/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf && \
    echo "userlist_enable=YES" >> /etc/vsftpd.conf && \
    echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf && \
    echo "userlist_deny=NO" >> /etc/vsftpd.conf

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]
