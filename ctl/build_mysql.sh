#!/bin/sh

docker build -t mysql:service srcs/03_mysql.d
kubectl apply -v2 -k srcs/.
