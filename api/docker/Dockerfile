FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com


ENV SPRING_DATA_MONGODB_DATABASE=dashboard
ENV SPRING_DATA_MONGODB_HOST=hygieia-mongodb
ENV SPRING_DATA_MONGODB_PORT=27017
ENV SPRING_DATA_MONGODB_USERNAME=dashboarduser
ENV SPRING_DATA_MONGODB_PASSWORD=dbpassword
ENV AUTH_EXPIRATION_TIME=7200000
ENV jasypt.encryptor.password=hygieiasecret
ENV AUTH_SECRET=hygieiasecret

RUN \
  mkdir /hygieia

COPY hygieia/ /hygieia
COPY properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

EXPOSE 8080
CMD ./properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/dashboard.properties