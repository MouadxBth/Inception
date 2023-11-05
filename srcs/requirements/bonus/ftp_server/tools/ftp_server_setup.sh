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

## Adding userlist_enable=YES to /etc/vsftpd.conf
#
# Used to enable userlist support, which allows specifying user access rules in the 
# "/etc/vsftpd.userlist" file
echo "userlist_enable=YES" >> /etc/vsftpd.conf 

## Adding userlist_file=/etc/vsftpd.userlist to /etc/vsftpd.conf
#
# Used to specify the location of the userlist file
echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf 

## Adding the "FTP_USER" to /etc/vsftpd.userlist
#
# Used to grant FTP_USER access to the FTP server
echo ${FTP_USER} >> /etc/vsftpd.userlist 

## Adding write_enable=YES to /etc/vsftpd.conf
#
# Used to allow write/upload access to the FTP users
echo "write_enable=YES" >> /etc/vsftpd.conf 

## Adding chroot_local_user=YES to /etc/vsftpd.conf
#
# Used to restrict FTP users to their home directories upon login (for security reasons)
echo "chroot_local_user=YES" >> /etc/vsftpd.conf 

## Adding allow_writeable_chroot=YES to /etc/vsftpd.conf
#
# Used to allow chrooted users (users restricted to their home directories) to write files and
# create directories within their home directories
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf 

echo "userlist_deny=NO" >> /etc/vsftpd.conf

## Adding dirlist_enable=YES to /etc/vsftpd.conf
#
# Used to allow FTP users to see the contents of directories when they are connected to the
# FTP server
echo "dirlist_enable=YES" >> /etc/vsftpd.conf

## Adding pasv_enable=YES to /etc/vsftpd.conf
#
# Used to enable passive mode for data connections, FTP can operate in 2 different
# modes: Active mode and Passive mode
#
# Active mode allows the user to control both, the control connection (used for commands and
# responses), and the data connection (used for actual file transfers).
#
# Passive mode makes the server setup the data connection, providing an available port and an
# ip address (usually different from it's own) where the client can connect and receive data.
#
# Passive mode is often used when the FTP server is behind a firewall or network address 
# translation (NAT, which is also our case) device because it allows clients to establish 
# data connections to the server, without having to manually open a port for data connections
echo "pasv_enable=YES" >> /etc/vsftpd.conf

## Adding pasv_min_port=40100 to /etc/vsftpd.conf
#
# Used to specify the minimum port range for data connections
echo "pasv_min_port=40100" >> /etc/vsftpd.conf

## Adding pasv_max_port=40200 to /etc/vsftpd.conf
#
# Used to specify the maximum port range for data connections
echo "pasv_max_port=40200" >> /etc/vsftpd.conf

# service vsftpd start

# service vsftpd stop

## Starting the FTP server with the given configuration
exec "/usr/sbin/vsftpd" "/etc/vsftpd.conf"