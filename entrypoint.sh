#!/bin/sh
set -e

AGENT_PORT=${AGENT_PORT:=1540}
MANAGER_PORT=${MANAGER_PORT:=1541}
RANGE_PORT_START=${RANGE_PORT_START:=1560}
RANGE_PORT_END=${RANGE_PORT_END:=1591}
RAS_PORT=${RAS_PORT:=1545}

SERVER_NAME=${SERVER_NAME:=$HOSTNAME}

if [[ "$1" = 'nginx' ]]
then    
    echo "hostname: $HOSTNAME"
    nginx -g "daemon off;"
fi

exec "$@"



