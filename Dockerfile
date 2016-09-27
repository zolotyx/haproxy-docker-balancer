FROM haproxy:1.5

RUN \
	apt-get update && \
    apt-get -y --no-install-recommends install wget

RUN wget --no-check-certificate https://github.com/jwilder/docker-gen/releases/download/0.7.3/docker-gen-linux-amd64-0.7.3.tar.gz && \
	tar xvzf docker-gen-linux-amd64-0.7.3.tar.gz && \
	mv docker-gen /etc

# COPY haproxy.cfg /usr/local/etc/haproxy
COPY docker-gen.cfg /etc/docker-gen.cfg
COPY haproxy.tmpl /etc/haproxy/haproxy.tmpl

# Add startup scripts manager
COPY ./startup.sh /bin/startup
RUN  chmod +x /bin/startup


COPY docker-gen.service  /etc/systemd/system/docker-gen.service

EXPOSE 80

ENTRYPOINT ["/bin/bash","/bin/startup"]




