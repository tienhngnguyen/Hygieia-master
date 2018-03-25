
FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com

RUN \
  mkdir /hygieia

COPY /docker/jenkins-build-collector-2.0.5-SNAPSHOT.jar /hygieia/
COPY /docker/properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

CMD ./jenkins-build-properties-builder.sh && \
  java -jar jenkins-build-collector*.jar --spring.config.location=/hygieia/hygieia-jenkins-build-collector.properties