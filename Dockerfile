FROM ubuntu:latest
MAINTAINER Mike Wilson <geekinutah@gmail.com>

ENV TERM=xterm-256color
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV RQ_QUEUE=default
ENV LOG_LEVEL=DEBUG
ENV IMPORT_PATH=/pythonimports
ENV PIP_PACKAGES=none

RUN apt-get -q update >/dev/null \
    && apt-get install -y python python-dev curl build-essential git supervisord \
    && curl https://bootstrap.pypa.io/get-pip.py | python \
    && pip install rq \
    && if [ ${PIP_PACKAGES} != 'none' ]; then for i in $(echo ${PIP_PACKAGES} | sed 's/,/ /g'; do pip install $i; done; fi
    # Above needs to be added to entry point
    # Cleanup
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ 


#COPY start_ssh_server.sh /usr/bin/start_ssh_server.sh
VOLUME ["/pythonimports"]

#ENTRYPOINT ["/usr/bin/start_ssh_server.sh"]
ENTRYPOINT ["/usr/bin/true"]
