FROM haproxy:1.5

COPY ./apt-tools /usr/share/apt-tools

RUN \
    chmod +x /usr/share/apt-tools/*.sh && \
    ln -s /usr/share/apt-tools/apt-install.sh /bin/apt-install && \
    ln -s /usr/share/apt-tools/apt-rollback.sh /bin/apt-rollback && \
    ln -s /usr/share/apt-tools/apt-commit.sh /bin/apt-commit

RUN \
    apt-install wget && \
    wget --no-check-certificate https://github.com/jwilder/docker-gen/releases/download/0.7.3/docker-gen-linux-amd64-0.7.3.tar.gz && \
    tar xvzf docker-gen-linux-amd64-0.7.3.tar.gz && \
    mv docker-gen /etc && \
    apt-rollback

RUN \
    apt-install supervisor && \
    apt-commit

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# COPY haproxy.cfg /usr/local/etc/haproxy
COPY docker-gen.cfg /etc/docker-gen.cfg
COPY haproxy.tmpl /etc/haproxy/haproxy.tmpl

# Add startup scripts manager
COPY ./startup.sh /bin/startup
RUN  chmod +x /bin/startup


COPY docker-gen.service  /etc/systemd/system/docker-gen.service

EXPOSE 80

CMD ["/usr/bin/supervisord"]
#ENTRYPOINT ["/bin/bash","/bin/startup"]




