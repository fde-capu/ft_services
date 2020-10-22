#!/bin/sh


kubectl create deployment _name _image _opt1 _opt2
kubectl logs _podname
kubectl edit deployment _name
kubectl delete deployment _name
kubectl get nodes | pod | services | replicaset | deployment
kubectl exec -it _podname -- bin/bash
kubectl describe pod _podname

# creates or updates:
kubectl apply -f _config_file.yaml
kubectl delete -g _config_file.yaml <- deletes with the file

minikube addons enable ingress <- ingress controler

# Builds image
#docker build -t ft_services .

# Run container
#docker run --privileged=true -d \
#	--name alpine ft_services
#	-v "/$(pwd)/srcs/autoindex_folder:/var/www/ft_server/html/autoindex" \

# Just for verbose sake
#docker ps
#docker logs alpine
