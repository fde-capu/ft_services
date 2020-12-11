#!/bin/sh
touch /INFLUXDB_CONTAINER
apk update
apk add influxdb
influxd &
sleep 3
influx -execute "create database grafana;"
tail -f /dev/null
