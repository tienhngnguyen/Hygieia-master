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

#COPY hygieia/ /hygieia
COPY /docker/api.jar /hygieia/
COPY /docker/properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

#TEMP
RUN chmod a+x properties-builder.sh
RUN chmod a+x /hygieia/dashboard.properties


EXPOSE 8080
CMD sh properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/dashboard.properties

RUN sed -i -e 's/\r$//' ./properties-builder.sh