#!/bin/sh
touch /INFLUX_CONTAINER
set -e
ln -s /telegraf.conf /etc/telegraf/telegraf.conf
influxd &
exec telegraf
