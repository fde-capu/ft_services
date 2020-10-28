#!/bin/sh

minikube version
minikube start --cpus 4 --memory 8192 --v=7 --vm-driver=virtualbox
kubectl version
minikube status
echo "Check this out:\n minikube ip: \t\t- `minikube ip` \n 01_metallb.yaml: `cat srcs/01_metallb.yaml | tail -1` \n"
eval $(minikube docker-env)
minikube addons enable metallb
kubectl apply -f srcs/01_metallb.yaml
docker build -t nginx:services srcs/02_nginx_context/
kubectl apply -f srcs/02_nginx.yaml


#kubectl apply -f srcs/03_nginx.yaml
# wait
#kubectl get service nginx
#kubectl describe service nginx

echo '\n42 São Paulo :: ft_services :: fde-capu\n'
sleep 1
minikube dashboard &
echo '\n42 São Paulo :: ft_services :: fde-capu\n'
