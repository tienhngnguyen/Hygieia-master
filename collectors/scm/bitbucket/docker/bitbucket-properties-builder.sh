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
	PROP_FILE=hygieia-bitbucket-scm-collector.properties
fi
  
# if [ "$MONGO_PORT" != "" ]; then
echo "Using Port: $HYGIEIA_MONGODB_PORT_27017_TCP_PORT"
if [ "$HYGIEIA_MONGODB_PORT_27017_TCP_PORT" != "" ]; then
	# Sample: MONGO_PORT=tcp://172.17.0.20:27017
	MONGODB_HOST=`echo $HYGIEIA_MONGODB_PORT_27017_TCP_PORT|sed 's;.*://\([^:]*\):\(.*\);\1;'`
	MONGODB_PORT=`echo $HYGIEIA_MONGODB_PORT_27017_TCP_PORT|sed 's;.*://\([^:]*\):\(.*\);\2;'`
else
	env
	echo "ERROR: MONGO_PORT not defined"
	exit 1
fi

echo "MONGODB_HOST: $MONGODB_HOST"
echo "MONGODB_PORT: $MONGODB_PORT"


cat > $PROP_FILE <<EOF
#Database Name
dbname=dashboarddb

#Database HostName - default is localhost
dbhost=hygieia-mongodb

#Database Port - default is 27017
dbport=27017

#Database Username - default is blank
dbusername=dashboarduser

#Database Password - default is blank
dbpassword=dbpassword

#Collector schedule (required)
git.cron=${BITBUCKET_CRON:-0 0/5 * * * *}

#mandatory
#git.host=${BITBUCKET_HOST:-mybitbucketrepo.com/}
git.host=bitbucket-server-dashboard.127.0.0.1.nip.io
git.api=${BITBUCKET_API:-/rest/api/1.0/}

#Maximum number of days to go back in time when fetching commits. Only applicable to Bitbucket Cloud.
git.commitThresholdDays=${BITBUCKET_COMMIT_THRESHOLD_DAYS:-15}

#Page size for rest calls. Only applicable to Bitbucket Server.
git.pageSize=${BITBUCKET_PAGE_SIZE,-25}

#Bitbucket product
# Set to "cloud" to use Bitbucket Cloud (formerly known as Bitbucket)
# Set to "server" to use Bitbucket Server (formerly known as Stash)
# More information can be found here: href="https://github.com/capitalone/Hygieia/issues/609
git.product=${BITBUCKET_PRODUCT:-cloud}

EOF

echo "

===========================================
Properties file created `date`:  $PROP_FILE
Note: passwords hidden
===========================================
`cat $PROP_FILE |egrep -vi password`
 "

exit 0
