#!/bin/sh
touch /TELEGRAF_CONTAINER
set -e
influxd &
exec telegraf
