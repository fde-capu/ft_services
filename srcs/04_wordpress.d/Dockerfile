FROM		alpine:3.12
COPY		latest.tar.gz /
RUN			tar -xf /latest.tar.gz -C /
EXPOSE		5050
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
