#!/bin/sh
touch /INFLUX_AND_TELEGRAF_CONTAINER
set -e
echo "[[inputs.kubernetes]]" >> /etc/telegraf/telegraf.conf
influxd &
exec telegraf
