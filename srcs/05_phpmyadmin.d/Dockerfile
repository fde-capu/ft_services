FROM		alpine:latest
RUN			apk update
RUN			apk add nginx
RUN			apk add openssl
RUN			apk add php7-fpm php7-mbstring php7-mcrypt php7-soap php7-openssl php7-gmp \
			php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli \
			php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
			php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
			php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-common \
			php7-xml php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-posix \
			php7-ldap php7-dom php7-session
RUN			mkdir -p /run/nginx && \
			mkdir -p /etc/nginx/ssl && \
			rm -f /etc/nginx/conf.d/default.conf
RUN			apk add phpmyadmin
COPY		server* /
COPY		pma_nginx.conf /
COPY		config.inc.php /
EXPOSE		5000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
