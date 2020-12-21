#!/bin/sh
touch /INFLUX_CONTAINER
set -e
influxd -config /influxdb.conf &
exec telegraf -config /telegraf.conf
