#!/bin/sh

echo "\n\nminikube start\n===========\n"
minikube start --cpus 4 --memory 8192 \
	--disk-size 2g --v=7 --vm-driver=virtualbox
echo "\n\nminikube ip check\n===========\n"
mkip=`minikube ip`
sed "s/{MINIKUBE_IP}/${mkip}-${mkip}/g" \
	srcs/01_metallb-template.yaml \
	> srcs/01_metallb.yaml
echo "Check this out:\n minikube ip: \
	\t\t`minikube ip` \n 01_metallb.yaml: \
	`cat srcs/01_metallb.yaml | tail -1` \n"
echo "\n\nminikube docker-env\n===========\n"
eval $(minikube docker-env)

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
echo "\n\nkubectl apply -l srcs/.\n===========\n"
kubectl apply -k srcs/.

echo "\n\nLogs:\n===========\n"
kubectl get secrets
kubectl get pvc
kubectl get pods
kubectl get service nginx
kubectl get service mysql
kubectl get service wordpress
minikube service wordpress --url

echo \
	'\n42 São Paulo :: ft_services :: fde-capu\n'
sleep 1
#minikube dashboard &
#echo '\n42 São Paulo :: ft_services :: fde-capu\n'
