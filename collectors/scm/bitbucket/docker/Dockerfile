
FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com

RUN \
  mkdir /hygieia

COPY /docker/*.jar /hygieia/
COPY /docker/bitbucket-properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

CMD ./bitbucket-properties-builder.sh && \
  java -jar bitbucket-scm-collector*.jar --spring.config.location=/hygieia/hygieia-bitbucket-scm-collector.properties

