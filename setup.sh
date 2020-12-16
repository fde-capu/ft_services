#!/bin/sh
set -e
SLEEP_SECONDS=60

echo "\n\nminikube delete\n=========\n"
minikube delete

echo "\n\nminikube start\n===========\n"
minikube start --cpus 4 --memory 8192 \
	--disk-size 5g --v=7 --vm-driver=virtualbox

echo "\n\nmetalLB pre configuration\n===========\n"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

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
#kubectl apply -f srcs/01_metallb.yaml

#docker build -t nginx:service srcs/02_nginx.d
#kubectl apply -f srcs/02_nginx.yaml
#docker build -t mysql:service srcs/03_mysql.d
#kubectl apply -f srcs/03_mysql.yaml
#docker build -t wordpress:service \
#	srcs/04_wordpress.d
#kubectl apply -f srcs/04_wordpress.yaml

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
