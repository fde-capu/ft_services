#!/bin/sh
touch /FTPS_CONTAINER
set -e
ln /server.key /etc/ssl/private/server.key
ln /server.crt /etc/ssl/certs/server.crt
set -ex
mkdir -p /home/user42
echo "ftps container: This is a test file for ftps located at root folder /." > /test.txt
echo "ftps container: This is a test file for ftps located on /home/user42." > /home/user42/test.txt
chown user42 /home/user42
chown user42 /home/user42/test.txt
chown user42 /var/lib/ftp
mkdir -p /mnt/sql
vsftpd /etc/vsftpd/vsftpd.conf
/bin/sh /telegraf.sh &
exec /bin/sh /health_check.sh vsftpd
