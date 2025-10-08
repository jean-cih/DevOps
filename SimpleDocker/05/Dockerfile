FROM debian:latest

LABEL maintainer="evgenijpocekutov6@gmail.com"

ARG ADMIN_USER="dorenesh"

RUN apt-get update && apt-get install -y \
    gcc \
    make \
    libfcgi-dev \
    nginx \
    spawn-fcgi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./server.c /server.c

RUN gcc -o mini_server /server.c -lfcgi \
    && rm /server.c \
    && chmod +x mini_server

CMD spawn-fcgi -p 8080 ./mini_server \
    nginx -g "daemon off;"
