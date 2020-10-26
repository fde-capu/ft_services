#!/bin/sh

minikube version
#minikube start
minikube status
kubectl version
minikube addons enable metallb
minikube ip
kubectl apply -f srcs/01_metallb.yaml


#kubectl apply -f srcs/03_nginx.yaml
# wait
#kubectl get service nginx
#kubectl describe service nginx


#minikube dashboard
