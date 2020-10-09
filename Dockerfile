# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-capu <fde-capu@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/09 17:29:27 by fde-capu          #+#    #+#              #
#    Updated: 2020/10/09 18:31:42 by fde-capu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine
LABEL		maintainer=fde-capu

RUN			apk update 
#			apk add openrc && \
#			apk add mysql mysql-client && \
#			rc-service mariadb start
#			apt-get install apt-utils vim procps wget -y && \
#			apt-get install nginx -y && \
#			apt-get install php php-fpm php-mysql -y && \
#			apt-get install mariadb-server mariadb-client -y && \
#			apt-get install php-mbstring php-bz2 php-zip -y && \
#			wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
#			wget wordpress.org/latest.tar.gz

# nginx
#RUN			mkdir -p /var/www/ft_server/html && \
#			rm -f /etc/nginx/sites-enabled/default
#COPY			srcs/index.html /var/www/ft_server/html/index.html
#COPY		srcs/ft_server /etc/nginx/sites-available
#RUN			ln -s /etc/nginx/sites-available/ft_server \
#				/etc/nginx/sites-enabled
#COPY		srcs/favicon.ico /var/www/ft_server/html
#
## autoindex
#COPY		srcs/autoindex /usr/bin
#RUN			chmod +x /usr/bin/autoindex
#
## SSL
#COPY		srcs/localhost.* /etc/ssl/certs/
#RUN			chmod 600 /etc/ssl/certs/localhost*
#
## PHP
#RUN			mkdir -p /var/www/ft_server/html/php
#COPY		srcs/index.php /var/www/ft_server/html/php/index.php
#
## MySQL / MariaDB
#RUN			mkdir -p /var/www/ft_server/html/mariadb
#COPY		srcs/mariadb-index.php \
#				/var/www/ft_server/html/mariadb/index.php
#
## PHPMyAdmin
#RUN			mkdir -p /var/www/ft_server/html/phpmyadmin && \
#			tar -xf phpMyAdmin-latest-english.tar.gz --strip=1 -C \
#				/var/www/ft_server/html/phpmyadmin
#
## WordPress
#RUN			tar -xf latest.tar.gz -C /var/www/ft_server/html
#
## tell users that these ports are in use
#EXPOSE		80 443
#
## start services
COPY		srcs/start_ft_services.sh /
ENTRYPOINT	["bash", "/start_ft_services.sh"]
