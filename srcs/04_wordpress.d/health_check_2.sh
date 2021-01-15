#!/bin/sh
set -x
while true
do
	sleep 3
	if ! pgrep "$1" ; then
		exit 1
	fi
	if ! pgrep "$2" ; then
		exit 2
	fi
done
exit 3
