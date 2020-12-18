#!/bin/sh
set -ex
CPUS=3
MEM='8g'
SSD='4g'
#DRIVER='virtualbox'
DRIVER='docker'
SLEEP_SECONDS=30

echo "\n\nminikube delete\n=========\n"
minikube delete

echo "\n\nminikube start\n===========\n"
minikube start --cpus $CPUS --memory $MEM \
	--disk-size $SSD --v=7 --vm-driver=$DRIVER

echo "\n\nminikube ip check\n===========\n"
mkip=`minikube ip`
sleep 1
sed "s/{MINIKUBE_IP}/${mkip}-${mkip}/g" \
	srcs/01_metallb-template.yaml \
	> srcs/01_metallb.yaml
echo "Check this out:\n minikube ip: \
	\t\t`minikube ip` \n 01_metallb.yaml: \
	`cat srcs/01_metallb.yaml | tail -1` \n"

echo "\n\nminikube docker-env\n===========\n"
eval $(minikube docker-env)

echo "\n\nvsftpd.conf add pasv_address=$mkip \n========"
cp srcs/06_ftps.d/vsftpd.conf-template srcs/06_ftps.d/vsftpd.conf
echo "pasv_address=$mkip" >> srcs/06_ftps.d/vsftpd.conf

echo "\n\nminikube addons enable metallb\n===========\n"
minikube addons enable metallb
echo "\n\nBuild: 02_nginx\n===========\n"
docker build -t nginx:service srcs/02_nginx.d
echo "\n\nBuild: 03_mysql\n===========\n"
docker build -t mysql:service srcs/03_mysql.d
echo "\n\nBuild: 04_wordpress\n===========\n"
docker build -t wordpress:service srcs/04_wordpress.d
echo "\n\nBuild: 05_phpmyadmin\n===========\n"
docker build -t phpmyadmin:service srcs/05_phpmyadmin.d
echo "\n\nBuild: 06_ftps\n===========\n"
docker build -t ftps:service srcs/06_ftps.d
echo "\n\nBuild: 07_Grafana\n===========\n"
docker build -t grafana:service srcs/07_grafana.d
echo "\n\nBuild: 08_influxdb\n===========\n"
docker build -t influxdb:service srcs/08_influxdb.d

echo "\nCleaning..."
rm srcs/06_ftps.d/vsftpd.conf
echo "ok"

echo "\n\nkubectl apply -l srcs/.\n===========\n"

kubectl apply -v2 -k srcs/.

echo "\n\nLogs:\n=========== (sleep $SLEEP_SECONDS)\n"
sleep $SLEEP_SECONDS
ctl/logs.sh

echo \
	'\n42 São Paulo :: ft_services :: fde-capu\n'
sleep 1

# dependencies:
#curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#chmod +x minikube
#➜  ~ sudo mkdir -p /usr/local/bin
#➜  ~ sudo install minikube /usr/local/bin
#sudo groupadd docker
#sudo usermod -aG docker user42
#newgrp docker
# source <(kubectl completion zsh)
# sudo apt install lftp # for unit test:
