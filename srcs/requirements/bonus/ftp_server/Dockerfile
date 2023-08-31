FROM debian:bullseye

RUN apt update -y && \
    apt install -y vsftpd

RUN mkdir -p /var/www/wordpress
RUN adduser --system --home /var/www/wordpress --shell /bin/false --ingroup root --no-create-home ftpmbouthai

RUN echo "ftpmbouthai:123456" | /usr/sbin/chpasswd && \
    sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g" /etc/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g" /etc/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g" /etc/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g" /etc/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf &&\
    echo "seccomp_sandbox=NO" >> /etc/vsftpd.conf && \
    echo "pasv_enable=YES" >> /etc/vsftpd.conf

WORKDIR /var/www/wordpress


CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]
