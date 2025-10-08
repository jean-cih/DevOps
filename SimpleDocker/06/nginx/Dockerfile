FROM nginx

WORKDIR /nginx_server

RUN apt update && apt upgrade \
    && apt-get install -y mc \
    && apt-get install -y procps \
    && rm -rf /var/lib/apt/lists

COPY nginx_conf/default.conf ../etc/nginx/conf.d/default.conf
COPY nginx_conf/nginx.conf ../etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
