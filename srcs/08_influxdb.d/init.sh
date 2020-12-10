#!/bin/sh
touch /INFLUX_DB_CONTAINER
apk update
apk add influxdb
influxd &
tail -f /dev/null
