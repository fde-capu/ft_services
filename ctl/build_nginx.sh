#!/bin/sh

docker build -t nginx:service srcs/02_nginx.d

kubectl apply -v2 -k srcs/.
