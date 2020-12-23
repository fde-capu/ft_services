#!/bin/sh
touch /INFLUX_CONTAINER
set -e
#influxd &
influxd -config /influxdb.conf &
sleep 3
influx -execute "create database telegraf"
/bin/sh /telegraf.sh
tail -f /dev/null
