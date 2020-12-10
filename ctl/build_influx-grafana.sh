#!/bin/sh

docker build -t influxdb:service srcs/08_influxdb.d
docker build -t grafana:service srcs/07_grafana.d

kubectl apply -v2 -k srcs/.
