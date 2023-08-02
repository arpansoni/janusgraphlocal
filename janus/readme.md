1) first downlaod janusgraphfull from janusgraph git 
    https://github.com/JanusGraph/janusgraph/releases/tag/v0.6.3
2) unzip the zip file 
3) add the following files to root directory of your unzipped directory 
    docker-compose.yml
    docker-entrypint.sh
    Dockerfile
    Graphsetup.template
4) replace gremlin-server.yaml to
   confg/gremlin-server/gremlin-server.yaml
5) replace janusgraph-cql-configurationgraph.properties
    in conf directory
6) modify the file janusgraph-server.sh in bin directory 
   there is a copy for refernce but please try to make the chage locally instead 
   of copying the full file 
    changes in this there are 2 changes made here 
     Line 74 should be if [[ "$1" ]]; then 
     line 211- 214 change it to 
    $JAVA -Dlog4j.configuration=$LOG4J_CONF $JAVA_OPTIONS -cp $CLASSPATH $JANUSGRAPH_SERVER_CMD "$JANUSGRAPH_YAML"
    PID=$!
    disown $PID
    echo $PID > "$PID_FILE"

7) after this  build image using the podman build -t "name of image" . 
8) push the image is pushed to harbor 
   example 
     podman push 20ea1e2764d80ca26281866ca947eb0a28fbab1b0a7b7ec938b8e3e436a5d39c registry.us-east-1.dev.internal/gravitylens/janusgraphbuild1-latest --creds=asoni
  make  nessary changes to line above and proivde the correct hash and your username
9) deploy cassandra cluster by switching to where the cassandra and janusgraph server yaml files are  
   kubectl apply -f cassandra-persistentvolumeclaim.yaml,cassandra-service.yaml,cassandra-deployment.yaml 
10) check to see if cassandra cluster is running without error
11) run kubectl get svc 
    check to see cassandra service is running properly 
    note the name of the service it should be cassandra 
12) create env variables 
     export  CASSANDRA_SERVICE_HOST=cassandra.{kube namespace}.svc.cluster.local
     above command replace the name of the name space of kubernetes cluster namespace and run the command 

      export  CASSANDRA_USERNAME=cassandra
      export CASSANDRA_PASSWORD=cassandra
16) in janusgraph-deployment.yaml refrence the image you have pushed to harbor 
    it should be something like 
    - image: registry.us-east-1.dev.internal/gravitylens/janusgraphbuild1-latest@sha256:6b11ccce4b6ab8b937581e0dc7aaa0c419f72480f08256393eabe34d7ac0124d

15) deploy janusgraph server  using 
     kubectl apply -f janusgraph-networkpolicy.yaml,janusgraph-service.yaml,janusgraph-deployment.yaml 

16) if the server is running without any error please follow the kubernetes-setup.pdf files from section "SETUP GRAPH"