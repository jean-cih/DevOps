FROM nginx:latest
LABEL maintainer="evgenijpocekutov6@gmail.com"
ENV ADMIN="dorenesh"
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    libfcgi-dev \
    nginx \
    spawn-fcgi
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./server.c /server.c
CMD gcc -o mini_server ./server.c -lfcgi \
    spawn-fcgi -p 8080 ./mini_server \
    nginx -g "daemon off;"