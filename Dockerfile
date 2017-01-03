#
# Dockerfile for ShadowsocksR
#

FROM alpine

RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD    p@ssw0rd
ENV METHOD      aes-256-cfb
ENV PROTOCOL    auth_sha1_v2_compatible
ENV OBFS        http_simple
ENV TIMEOUT     60
ENV DNS_ADDR    8.8.8.8

EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp

WORKDIR /usr/bin/

CMD /usr/bin/ssserver -s $SERVER_ADDR \
                      -p $SERVER_PORT \
                      -k $PASSWORD    \
                      -m $METHOD      \
                      -O $PROTOCOL    \
                      -o $OBFS        \
                      -t $TIMEOUT
