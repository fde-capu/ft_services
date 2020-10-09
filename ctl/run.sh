#!/bin/sh

# Foreplay
sudo apt-get update
sudo apt-get install docker
sudo dockerd
sudo apt-get install virtualbox
sudo snap install minikube

# Builds image
docker build -t ft_services .

# Run container
docker run --privileged=true -d \
	--name alpine ft_services
#	-v "/$(pwd)/srcs/autoindex_folder:/var/www/ft_server/html/autoindex" \

# Just for verbose sake
docker ps
docker logs alpine
