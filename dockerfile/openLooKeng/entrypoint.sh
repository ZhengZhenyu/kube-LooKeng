#!/bin/bash
set -e
IS_COORDINATOR=${IS_COORDINATOR:-""}
if [ "$IS_COORDINATOR" == "true" ]; then
    echo "coordinator=true" >> etc/config.properties
else
    echo "coordinator=false" >> etc/config.properties
fi

INCLUDE_COORDINATOR={INCLUDE_COORDINATOR:-""}
if [ "$INCLUDE_COORDINATOR" != "" ]; then
    echo "node-scheduler.include-coordinator=true" >> etc/config.properties
fi

echo "http-server.http.port=$HTTP_PORT" >> etc/config.properties
echo "discovery.uri=$DISCOVERY_URI" >> etc/config.properties

echo "node.environment=$NODE_ENVIRONMENT" >> etc/node.properties 

/home/openlkadmin/hetu-server/bin/launcher run
