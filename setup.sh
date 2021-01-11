#!/bin/sh
CPUS=3
MEM='8g'
SSD='4g'
DRIVER=none
SLEEP_SECONDS=30

echo "\n\npre-config\n=========\n"
sudo minikube delete
#docker rm -f `docker ps -aq`
#docker rmi -f `docker images -aq`
#sudo rm -rf ~/.minikube
#sudo rm -rf /ft_services-fde-capu
set -e
export CHANGE_MINIKUBE_NONE_USER=true

echo "\n\nminikube start\n===========\n"
sudo -E minikube start --v=7 --vm-driver=$DRIVER
mkip=`minikube ip`
ssh-keygen -R $mkip
#sudo kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system

echo "\n\nminikube ip check\n===========\n"
#sed "s/{MINIKUBE_IP}/${hostmin}-${hostmax}/g" \
sed "s/{MINIKUBE_IP}/10.2.0.1-10.2.0.14/g" \
	srcs/01_metallb-template.yaml \
	> srcs/01_metallb.yaml
echo "Check this out:\n minikube ip: \
	\t\t`minikube ip` \n 01_metallb.yaml: \
	`cat srcs/01_metallb.yaml | tail -1` \n"
sleep 5

#echo "\n\nvsftpd.conf add pasv_address=$mkip \n========"
cp srcs/06_ftps.d/vsftpd.conf-template srcs/06_ftps.d/vsftpd.conf
#echo "pasv_address=$ftpsip" >> srcs/06_ftps.d/vsftpd.conf

echo "\n\nminikube addons enable metallb\n===========\n"
sudo -E minikube addons enable metallb

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

# VM Specs:
# -rw-r--r-- 1 fde-capu fde-capu 4807311872 Dec 17 08:38 english-version.ova
# fde-capu@N7FAA52318:~/vm$ sha256sum english-version.ova 
# ffc1f8d74b234891cc756a28a123df207bcbbde328fac1ba22f82f60d3805986  english-version.ova
# Ubuntu 64b
# Nested VT-x/AMD-V
# Default Paravirtualization
# Enabled Nested Paging
# Oracle Extension Pack 6.1.14
#
#
#

# dependencies:
#curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#chmod +x minikube
#➜  ~ sudo mkdir -p /usr/local/bin
#➜  ~ sudo install minikube /usr/local/bin
#sudo groupadd docker
#sudo usermod -aG docker user42
#newgrp docker
# sudo apt install lftp # for unit test:
# sudo pkill nginx
# sudo apt install conntrack # for driver=none
# sudo apt install ipcalc
# source <(kubectl completion szh)

# Tasks:
# every external ip unique
# all watching processes
# wordpress accounts
# review all telegrafs
