
FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com

RUN \
  mkdir /hygieia

COPY github-scm-collector-2.0.5-SNAPSHOT.jar /hygieia/
COPY github-properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

CMD ./github-properties-builder.sh && \
  java -jar github-scm-collector*.jar --spring.config.location=/hygieia/hygieia-github-scm-collector.properties

