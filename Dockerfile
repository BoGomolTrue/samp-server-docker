FROM debian:bookworm-slim

ARG SERVER_GZ
ARG SERVER_PATH

ENV SERVER_GZ ${SERVER_GZ}
ENV SERVER_PATH ${SERVER_PATH}

RUN dpkg --add-architecture i386
RUN apt update && \
    apt upgrade -yy && \
    apt install -yy \
       apt-utils \
       libstdc++6 \
       libncurses5:i386 \
       libstdc++6:i386 \
       procps 

COPY ${SERVER_GZ} /tmp/
RUN [ ! -d "${SERVER_PATH}" ] && cd /srv && tar xzvf /tmp/${SERVER_GZ}
RUN chmod +x ${SERVER_PATH}/samp03svr

RUN ln -sf /dev/stdout ${SERVER_PATH}/server_log.txt

EXPOSE 7777
COPY start.sh /start.sh

STOPSIGNAL SIGINT

WORKDIR ${SERVER_PATH}