#!/bin/bash

if [ "$SKIP_PROPERTIES_BUILDER" = true ]; then
  echo "Skipping properties builder"
  exit 0
fi

# mongo container provides the HOST/PORT
# api container provided DB Name, ID & PWD

if [ "$TEST_SCRIPT" != "" ]
then
        #for testing locally
        PROP_FILE=application.properties
else 
	PROP_FILE=hygieia-github-scm-collector.properties
fi
  #if [ "$MONGO_PORT" != "" ]; then
  #HYGIEIA_MONGODB_PORT=tcp://172.30.53.1:27017
echo "Using Port: $HYGIEIA_MONGODB_PORT_27017_TCP_PORT"
if [ "$HYGIEIA_MONGODB_PORT_27017_TCP_PORT" != "" ]; then
	# Sample: MONGO_PORT=tcp://172.17.0.20:27017
	MONGODB_HOST=`echo $HYGIEIA_MONGODB_PORT|sed 's;.*://\([^:]*\):\(.*\);\1;'`
	MONGODB_PORT=`echo $HYGIEIA_MONGODB_PORT|sed 's;.*://\([^:]*\):\(.*\);\2;'`
else
	env
	echo "ERROR: MONGO_PORT not defined"
	exit 1
fi

echo "MONGODB_HOST: $MONGODB_HOST"
echo "MONGODB_PORT: $MONGODB_PORT"


cat > $PROP_FILE <<EOF
#Database Name
dbname=${HYGIEIA_API_ENV_SPRING_DATA_MONGODB_DATABASE}

#Database HostName - default is localhost
dbhost=${SPRING_DATA_MONGODB_DATABASE}

#Database Port - default is 27017
dbport=${MONGODB_PORT}

#Database Username - default is blank
dbusername=${SPRING_DATA_MONGODB_USERNAME}

#Database Password - default is blank
dbpassword=${SPRING_DATA_MONGODB_PASSWORD}

#Collector schedule (required)
github.cron=${GITHUB_CRON:-0 0/5 * * * *}

github.host=${GITHUB_HOST:-github.com}

#Maximum number of days to go back in time when fetching commits
github.commitThresholdDays=${GITHUB_COMMIT_THRESHOLD_DAYS:-15}

#Optional: Error threshold count after which collector stops collecting for a collector item. Default is 2.
github.errorThreshold=${GITHUB_ERROR_THRESHOLD:-1}

#This is the key generated using the Encryption class in core
github.key=${GITHUB_KEY}

#personal access token generated from github and used for making authentiated calls
github.personalAccessToken=${PERSONAL_ACCESS_TOKEN}

EOF

echo "

===========================================
Properties file created `date`:  $PROP_FILE
Note: passwords hidden
===========================================
`cat $PROP_FILE |egrep -vi password`
 "

exit 0
