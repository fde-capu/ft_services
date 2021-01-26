#!/bin/sh
touch /INFLUX_CONTAINER
set -e
influxd -config /influxdb.conf &
sleep 3
influx -execute "create database telegraf" &
sed -i s/influxdb:8086/localhost:8086/ /telegraf.conf
/bin/sh /telegraf.sh &
exec /bin/sh /health_check.sh influxd telegraf
