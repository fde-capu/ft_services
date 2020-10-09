#!/bin/sh

# Generate a self signed SSL certificate
#openssl req -new -x509 -days 365 \
#	-newkey rsa:2048 -nodes \
#	-subj "/C=BR/L=SP/O=42SP/CN=localhost" \
#	-keyout srcs/localhost.key \
#	-out srcs/localhost.crt

# Builds image
docker build -t ft_services .

# Run container
docker run -d \
	--name alpine ft_services
#	-v "/$(pwd)/srcs/autoindex_folder:/var/www/ft_server/html/autoindex" \

# Just for verbose sake
docker ps
docker logs alpine
