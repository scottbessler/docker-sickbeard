FROM alpine:edge

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates git \
        py-pip ca-certificates git python py-libxml2 py-lxml py-pip  \
        make gcc g++ python-dev openssl-dev libffi-dev \
    && \
    pip --no-cache-dir install pyOpenSSL==0.15.1 Cheetah==2.4.4 && \
    git clone --depth 1 https://github.com/midgetspy/Sick-Beard /sickbeard && \
    apk del make gcc g++ python-dev && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

VOLUME ["/config"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8081

CMD ["/start.sh"]
