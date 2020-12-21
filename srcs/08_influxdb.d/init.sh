#!/bin/sh
touch /INFLUX_CONTAINER
set -e
ln -s /telegraf.conf /etc/telegraf/telegraf.conf
#rm -f /etc/influxdb.conf
#ln -s /influxdb.conf /etc/influxdb.conf
influxd &
exec telegraf
