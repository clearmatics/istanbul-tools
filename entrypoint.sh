#!/bin/sh
#
# Usage:
# docker run -it --name init04 init04 /efs/shared /genesis-template/genesis.json

# Defaults args
if [ "$#" -eq 0 ]; then
    set -- /efs/shared /genesis-template/genesis.json
fi

SHARED_PATH=$1
GENESIS_TPL_PATH=$2

############## Init Conditions ##########################
if [ -f $SHARED_PATH/genesis.json ]; then
    echo "INFO: Check initial conditions: "$SHARED_PATH"/genesis.json is exist. Skip generation steps."
    exit 0
fi

if [ ! -f $SHARED_PATH/config.toml ]; then
    echo "ERROR: Check initial conditions: "$SHARED_PATH"/config.toml does not exist. Exit"
    exit 1
fi

EXTRA="$(/go/bin/istanbul extra encode --config $SHARED_PATH/config.toml |cut -d':' -f2 | tr -d " \t\n\r")"
echo "Encoded Istanbul extra-data: "$EXTRA

./write_genesis.py -t $GENESIS_TPL_PATH -f $SHARED_PATH"/genesis.json" -e $EXTRA  || { echo "ERROR: Job04: generate genesis.json file" ; exit 1; }

echo "INFO: "$SHARED_PATH"/genesis.json was generated successfully"
