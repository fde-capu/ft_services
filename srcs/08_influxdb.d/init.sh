#!/bin/sh
touch /INFLUX_CONTAINER
set -e
#influxd &
influxd -config /influxdb.conf &
sleep 3
influx -execute "create database telegraf"
#influx -execute "use telegraf"
#influx -execute "create user telegraf with password 'metricsmetricsmetricsmetrics' with all privileges"
#influx -execute "grant all privileges on telegraf to telegraf"
tail -f /dev/null
