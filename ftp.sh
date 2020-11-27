#!/bin/sh
set -e
mkip=`minikube ip`
echo "\n\nvsftpd.conf\n========"
#cp srcs/06_ftps.d/vsftpd.conf-template srcs/06_ftps.d/vsftpd.conf
#echo "pasv_address=$mkip" >> srcs/06_ftps.d/vsftpd.conf
docker build --no-cache -t ftps:service srcs/06_ftps.d/
kubectl apply -v3 -f srcs/06_ftps.yaml
ftp $mkip
