#!/bin/sh

chmod -R 750 /var/www/wordpress 

chown -R ftpmbouthai:ftpmbouthai  /var/www/wordpress 

echo "ftpmbouthai" >> /etc/vsftpd.userlist 

echo "ftpmbouthai:123456" | /usr/sbin/chpasswd 

echo "write_enable=YES" >> /etc/vsftpd.conf 

echo "chroot_local_user=YES" >> /etc/vsftpd.conf 

echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf 

echo "userlist_enable=YES" >> /etc/vsftpd.conf 

echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf 

echo "userlist_deny=NO" >> /etc/vsftpd.conf

service vsftpd start

service vsftpd stop

exec "/usr/sbin/vsftpd" "/etc/vsftpd.conf"