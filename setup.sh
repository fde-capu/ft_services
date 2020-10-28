#!/bin/sh

minikube version
minikube start --memory 8192 --cpus 4 --v=7
kubectl version
minikube status
echo "Chek this out:\n minikube ip: \t\t   - `minikube ip` \n 01_metallb.yaml: `cat srcs/01_metallb.yaml | tail -1` \n"
eval $(minikube -p minikube docker-env)
minikube addons enable metallb
kubectl apply -f srcs/01_metallb.yaml
docker build srcs/02_nginx/02_nginx_Dockerfile
kubectl apply -f srcs/02_nginx.yaml


#kubectl apply -f srcs/03_nginx.yaml
# wait
#kubectl get service nginx
#kubectl describe service nginx


echo '\n42SP :: ft_services :: fde-capu'
echo 'use: `minikube dashboard`\n'
