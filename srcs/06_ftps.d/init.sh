#!/bin/sh
echo "This is a test file." > /test.txt
vsftpd
tail -f /dev/null
