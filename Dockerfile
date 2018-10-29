FROM ubuntu:latest
MAINTAINER Mike Wilson <geekinutah@gmail.com>

ENV TERM=xterm-256color
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_DB=0
ENV RQ_QUEUE=default
ENV LOG_LEVEL=DEBUG
ENV PIP_PACKAGES=none

RUN apt-get -q update >/dev/null \
    && apt-get install -y python3 python3-dev curl build-essential git supervisor \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install rq \
    && pip3 install Jinja \
    # Cleanup
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ 


#COPY start_ssh_server.sh /usr/bin/start_ssh_server.sh
COPY etc_supervisor_confd_rqworker.conf.j2 /etc/supervisor/conf.d/rqworker.conf.j2
VOLUME ["/pythonimports"]

#ENTRYPOINT ["/usr/bin/start_ssh_server.sh"]
ENTRYPOINT ["/bin/bash"]
