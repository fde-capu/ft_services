#!/bin/sh

ssh-keygen -R $(minikube ip)
ssh user42@$(minikube ip)
