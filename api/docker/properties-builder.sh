#!/bin/bash

if [ "$SKIP_PROPERTIES_BUILDER" = true ]; then
  echo "Skipping properties builder"
  exit 0
fi

# if we are linked, use that info
if [ "$MONGO_STARTED" != "" ]; then
  # links now use hostnames
  # todo: retrieve linked information such as hostname and port exposition
  export SPRING_DATA_MONGODB_HOST=mongodb
  export SPRING_DATA_MONGODB_PORT=27017
fi

echo "SPRING_DATA_MONGODB_HOST: $SPRING_DATA_MONGODB_HOST"
echo "SPRING_DATA_MONGODB_PORT: $SPRING_DATA_MONGODB_PORT"

#cat > dashboard.properties