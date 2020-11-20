FROM		alpine:latest
RUN			apk update && \
			apk add openssl
EXPOSE		3000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
