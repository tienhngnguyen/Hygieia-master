
FROM docker.io/nginx:latest

MAINTAINER Hygieia@capitalone.com


COPY /docker/default.conf /etc/nginx/conf.d/default.conf.templ
COPY /docker/conf-builder.sh /usr/bin/conf-builder.sh
COPY /docker/html /usr/share/nginx/html
#COPY html /usr/share/nginx/html
RUN chown nginx:nginx /usr/share/nginx/html

EXPOSE 80 443

RUN chmod -R 777 /usr/bin/
RUN chmod -R 777 /etc/nginx/conf.d/ 
#RUN tar -xf /usr/share/nginx/html/UI-2.0.5-SNAPSHOT-src.tar.gz

#RUN chmod +x /usr/bin/conf-builder.sh
#RUN chmod +x /etc/nginx/conf.d/default.conf.templ

#RUN chmod 777 /usr/bin/conf-builder.sh
#RUN chmod 777 /etc/nginx/conf.d/default.conf.templ

#RUN cfz UI-2.0.5-SNAPSHOT-src.tar.gz

CMD conf-builder.sh &&\
  nginx -g "daemon off;"

