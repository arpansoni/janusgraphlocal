#!/usr/bin/end bash

export CASSANDRA_HOSTNAME=${CASSANDRA_SERVICE_HOST:-localhost}
export CASSANDRA_PASSWORD=${CASSANDRA_PASSWORD:-cassandra}
export CASSANDRA_USERNAME=${CASSANDRA_USERNAME:-cassandra}

envsubst < conf/janusgraph-cql-configurationgraph.properties > conf/pod.properties
envsubst < GraphSetup.template > GraphSetup.groovy

echo "the pod properties" 
cat conf/pod.properties
pwd
ls -la
ls -la conf
ls -la conf/gremlin-server
echo" reading gremlin-server.yaml"
cat ./conf/gremlin-server/gremlin-server.yaml
echo "reading gremlin-server.yaml -full path "
cat /app/conf/gremlin-server/gremlin-server.yaml
./bin/janusgraph-server.sh console /app/conf/gremlin-server/gremlin-server.yaml
