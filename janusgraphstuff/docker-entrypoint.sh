#!/usr/bin/end bash

export CASSANDRA_HOSTNAME=${CASSANDRA_SERVICE_HOST:-localhost}
export CASSANDRA_PASSWORD=${CASSANDRA_PASSWORD:-cassandra}
export CASSANDRA_USERNAME=${CASSANDRA_USERNAME:-cassandra}

envsubst < conf/janusgraph-cql-configurationgraph.properties > conf/pod.properties
envsubst < GraphSetup.template > GraphSetup.groovy

echo "the pod properties" 
cat conf/pod.properties
./bin/janusgraph-server.sh start conf/gremlin-server/gremlin-server.yaml
