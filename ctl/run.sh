#!/bin/sh


# Builds image
docker build -t ft_services .

# Run container
docker run --privileged=true -d \
	--name alpine ft_services
#	-v "/$(pwd)/srcs/autoindex_folder:/var/www/ft_server/html/autoindex" \

# Just for verbose sake
docker ps
docker logs alpine
