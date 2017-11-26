FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com

USER root
ENV SPRING_DATA_MONGODB_DATABASE=dashboarddb
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
COPY /docker/dashboard.properties /hygieia/


WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

#TEMP
RUN chmod -R 777 /hygieia
RUN chmod a+x properties-builder.sh
RUN chmod -R 777 /hygieia/logs
#RUN chown -R daemon /hygieia/logs
#RUN chmod a+x dashboard.properties


EXPOSE 8080
CMD sh properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=dashboard.properties

#CMD sh properties-builder.sh &&\
#java -Djava.security.egd=file:/dev/./urandom -jar api.jar

RUN sed -i -e 's/\r$//' ./properties-builder.sh