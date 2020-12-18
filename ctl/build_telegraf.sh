#!/bin/sh

docker build -t influxdb:service srcs/08_influxdb.d

kubectl apply -v2 -k srcs/.
