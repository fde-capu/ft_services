#!/bin/sh
touch /INFLUX_AND_TELEGRAF_CONTAINER
set -e
influxd &
exec telegraf
