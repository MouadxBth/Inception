#!/bin/sh

## Append the path /usr/sbin/nologin to the /etc/shells file
#
# /etc/shells is a system file that contains a list of valid login shells.
#
# Adding /usr/sbin/nologin to this file indicates that it is a valid shell and can be used
# for certain system accounts that should not be allowed to log in interactively.
#
# This is often used for service accounts or FTP users who should not have shell access
echo /usr/sbin/nologin >> /etc/shells

## Create a group with the name stored in the "FTP_USER" variable
groupadd ${FTP_USER}

## Add a system user with:
#
# - the specified home directory (--home)
# - login shell (--shell)
# - and group (--ingroup).
# The --no-create-home flag indicates not to create a home directory for this user.
#
# This user is a system user intended for FTP access to the WordPress directory, and should
# not be allowed to log in interactively, and since the home directory for this system user
# will be mounted on container start up through an existing volume, it shouldn't re-create 
# this home directory folder.
adduser --system \
    --home /var/www/wordpress \
    --shell /usr/sbin/nologin \
    --ingroup ${FTP_USER} \
    --no-create-home \
    ${FTP_USER}

## Set the password for the FTP user.
echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd 

## Setting read, write, and execute permissions for the owner
# and read and execute permissions for others on these directories.
#
# This ensures that when connecting using an FTP client, it's able to change the directory
# to the specified FTP directory as well as the FTP user can access these directories and
# their contents.
chmod -R 755 /var/www && chmod -R 755 /var/www/wordpress 

## Change the ownership of the "/var/www/wordpress" directory to the FTP user and their group
# to ensures that the FTP user has full control over the WordPress directory and its contents
#
# Changing ownership to the FTP user is considered a best practice in terms of security
# and administrative control.
#
# It's a clear way to indicate that the FTP user has complete control over the directory, 
# and it's a common practice in setting up FTP server environments.
#
# it might seem redundant to use both chown and chmod to configure directory permissions,
# it is a recommended practice for ensuring that the FTP user has full ownership and control
# over the WordPress directory.
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

service vsftpd start

service vsftpd stop

exec "/usr/sbin/vsftpd" "/etc/vsftpd.conf"