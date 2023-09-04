#!/bin/sh

echo /usr/sbin/nologin >> /etc/shells

chmod -R 755 /var/www && chmod -R 755 /var/www/wordpress 

adduser --system \
    --home /var/www/wordpress \
    --shell /usr/sbin/nologin \
    --no-create-home \
    ${FTP_USER}

echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd 

echo "account sufficient pam_permit.so" >> /etc/pam.d/vsftpd

chown -R ${FTP_USER}:${FTP_USER}  /var/www/wordpress 

echo ${FTP_USER} >> /etc/vsftpd.userlist 

echo "write_enable=YES" >> /etc/vsftpd.conf 

echo "chroot_local_user=YES" >> /etc/vsftpd.conf 

echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf 

echo "userlist_enable=YES" >> /etc/vsftpd.conf 

echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf 

echo "userlist_deny=NO" >> /etc/vsftpd.conf

echo "dirlist_enable=YES" >> /etc/vsftpd.conf

echo "pasv_enable=YES" >> /etc/vsftpd.conf

echo "pasv_min_port=40100" >> /etc/vsftpd.conf

echo "pasv_max_port=40200" >> /etc/vsftpd.conf

echo -e "debug_enable=YES\n
dual_log_enable=YES\n
syslog_enable=YES\n
log_ftp_protocol=YES\n
xferlog_enable=YES\n" >> /etc/vsftpd.conf

service vsftpd start

service vsftpd stop

exec "/usr/sbin/vsftpd" "/etc/vsftpd.conf"