FROM nginx:latest

WORKDIR /first_server

RUN apt update && apt upgrade \
&& apt-get install -y gcc \
&& apt-get install -y libfcgi-dev  \
&& apt-get install -y spawn-fcgi \
&& apt-get install -y mc \
&& apt-get install -y procps \
&& rm -rf /var/lib/apt/lists

COPY server.c . 
COPY nginx/default.conf ../etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf ../etc/nginx/nginx.conf


CMD gcc server.c -o hello.cgi -lfcgi \
&& spawn-fcgi -p 8080 -n hello.cgi \
&& nginx -g 'daemon off;'
