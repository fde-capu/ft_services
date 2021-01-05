#!/bin/sh

python3 $(dirname $0)/unit.py $(minikube ip) user42 user42
##                            ^ ip           ^user  ^password
