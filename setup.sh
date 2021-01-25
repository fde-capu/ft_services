#!/bin/sh
set -e

/bin/sh srcs/pre-config.sh

SLEEP_SECONDS=30
DRIVER=none
export CHANGE_MINIKUBE_NONE_USER=true

echo "\n\nminikube ignite\n===========\n"
sudo -E minikube start --v=7 --vm-driver=$DRIVER
mkip=`minikube ip`

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

echo "\n\nkubectl applies\n===========\n"
kubectl apply -f srcs/01.5_vols.yaml
kubectl apply -f srcs/03_mysql.yaml
waitip="<pending>"
while [ "$waitip" = "<pending>" ]; do
	echo -n "."
	waitip=$(kubectl get svc | grep mysql | awk '{printf "%s", $3}')
	sleep 2
done
echo "\n(enable metallb)\n"
sudo -E minikube addons enable metallb
kubectl apply -f srcs/01_metallb.yaml
kubectl apply -f srcs/04_wordpress.yaml
kubectl apply -f srcs/05_phpmyadmin.yaml
kubectl apply -f srcs/06_ftps.yaml
kubectl apply -f srcs/08_influxdb.yaml
kubectl apply -f srcs/07_grafana.yaml

echo "\n\nBuild and apply: 02_nginx\n===========\n"
waitip="<pending>"
while [ "$waitip" = "<pending>" ]; do
	echo -n "."
	waitip=$(kubectl get svc | grep wordpress | awk '{printf "%s", $4}')
	sleep 3
done

sed "s/{WORDPRESS_EXTERNAL_IP}/$waitip/g" srcs/02_nginx.d/nginx.conf-template > srcs/02_nginx.d/nginx.conf
docker build -t nginx:service srcs/02_nginx.d
kubectl apply -f srcs/02_nginx.yaml

echo "ok"

echo "\n\nLogs:\n=========== (sleep $SLEEP_SECONDS)\n"
sleep $SLEEP_SECONDS
ctl/logs.sh

echo \
	'\n42 São Paulo :: ft_services :: fde-capu :: Welcome!\n'
sleep 1
