#!/bin/sh
touch /FTPS_CONTAINER
echo "ftps container: This is a test file for ftps located at root folder /." > /test.txt
echo "ftps container: This is a test file for ftps located on /home/user42." > /home/user42/test.txt
chown user42 /home/user42/test.txt
vsftpd
#tail -f /dev/null
