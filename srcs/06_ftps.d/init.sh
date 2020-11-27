#!/bin/sh
touch /FTPS_CONTAINER
echo "ftps container: This is a test file for ftps located at root folder /." > /test.txt
mkdir -p /home/user42
echo "ftps container: This is a test file for ftps located on /home/user42." > /home/user42/test.txt
chown user42 /home/user42
chown user42 /home/user42/test.txt
#chown user42 /var/lib/ftp
vsftpd /etc/vsftpd/vsftpd.conf
tail -f /dev/null
