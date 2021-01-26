#!/bin/sh

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

echo "\nFor interactive terminal, click:"
echo "\n"
echo "nginx: https://$nip"
echo "wordpress: https://$wip:5050"
echo "wordpress login: https://$wip:5050/wp-login.php"
echo "phpmyadmin direct: https://$pip:5000"
echo "phpmyadmin reverse proxy: https://$nip/phpmyadmin"
echo "ftp: $fip (for test, use 'lftp' instead of 'ftp', because of ssl. Then 'user user42' and 'set ssl:verify-certificate no'."
echo "grafana: https://$gip:3000"
echo "\n"
