
FROM docker.io/nginx:latest

MAINTAINER Hygieia@capitalone.com


COPY default.conf /etc/nginx/conf.d/default.conf.templ
COPY conf-builder.sh /usr/bin/conf-builder.sh
COPY UI-2.0.5-SNAPSHOT-src.tar.gz /usr/share/nginx/html
#COPY html /usr/share/nginx/html
RUN chown nginx:nginx /usr/share/nginx/html

EXPOSE 80 443

CMD conf-builder.sh &&\
  nginx -g "daemon off;"
