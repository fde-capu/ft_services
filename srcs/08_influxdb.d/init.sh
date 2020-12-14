#!/bin/sh
touch /INFLUXDB_CONTAINER
set -e
apk update
apk add influxdb
influxd &
sleep 3
influx -execute "create database grafana;"

wget https://dl.influxdata.com/telegraf/releases/$TELEGRAF.tar.gz
mkdir -p /usr/src /etc/telegraf
tar -C /usr/src -zxf telegraf-*.tar.gz
ln -s telegraf.conf /etc/telegraf/telegraf.conf
mkdir /etc/telegraf/telegraf.d
cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/
#if [ "${1:0:1}" = '-' ]; then
#    set -- telegraf "$@"
#fi
exec "$@" &


#tar -zxvf telegraf-* --strip 2
#mv telegraf.conf /etc/telegraf

tail -f /dev/null
