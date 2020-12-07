#!/bin/sh
touch /FTPS_CONTAINER
mkdir -p /mnt/sql
echo "ftps container: This is a test file for ftps located at root folder /." > /test.txt
echo "ftps container: This is a test file for ftps located on /home/user42." > /mnt/sql/test.txt
chown user42 /mnt/sql
#chown user42 /home/user42/test.txt
vsftpd /etc/vsftpd/vsftpd.conf
tail -f /dev/null
