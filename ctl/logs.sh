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

nip="$(kubectl get svc | grep nginx | awk '{printf "%s", $4}')"
wip="$(kubectl get svc | grep wordpress | awk '{printf "%s", $4}')"
pip="$(kubectl get svc | grep phpmyadmin | awk '{printf "%s", $4}')"
fip="$(kubectl get svc | grep ftps | awk '{printf "%s", $4}')"
gip="$(kubectl get svc | grep grafana | awk '{printf "%s", $4}')"

echo "For interactive terminal, click:"
echo ""
echo "https://$nip"
echo "https://$nip/wordpress"
echo "https://$nip/phpmyadmin"
echo "https://$gip:3000"
echo "https://$wip:5050"
echo "https://$pip:5000"
echo "ftp://$pip"
