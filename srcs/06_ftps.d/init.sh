#!/bin/sh
echo "This is a test file for ftps located at root folder /." > /test.txt
echo "This is a test file for ftps located on /var/lib/ftp." > /var/lib/ftp/test.txt
vsftpd
#tail -f /dev/null
