#!/bin/bash

minikube status

kubectl cluster-info
kubectl get secrets
kubectl get pvc
kubectl get pods
kubectl get service nginx
kubectl get service mysql
kubectl get service wordpress
kubectl get service ftps
kubectl get service grafana
kubectl get service influxdb
kubectl get svc

ip="$(kubectl get svc | grep nginx | awk '{printf "%s", $4}')"

echo "For interactive terminal, click:"
echo ""
echo "http://$ip/"
echo "http://$ip:443"
echo "http://$ip:80"
echo "http://$ip/wordpress"
echo "http://$ip:5050"
echo "http://$ip/phpmyadmin"
echo "http://$ip:5000"
echo "http://$ip/grafana"
echo "http://$ip:3000"
echo ""
echo "https://$ip/"
echo "https://$ip:443"
echo "https://$ip:80"
echo "https://$ip/wordpress"
echo "https://$ip:5050"
echo "https://$ip/phpmyadmin"
echo "https://$ip:5000"
echo "https://$ip/grafana"
echo "https://$ip:3000"
