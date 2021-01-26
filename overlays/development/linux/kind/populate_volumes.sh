#!/bin/bash

MAPDIR=~/idc
SNAPSHOT_TAG=upstream-20201007-739693ae-141-ga28f4f5.1611599337

if [ ! -d $MAPDIR ]; then
    mkdir $MAPDIR
fi

if [ ! -f /usr/bin/docker ]; then
    echo "Docker needs to be installed"
    exit ;
fi

if [ ! -d $MAPDIR/mariadb-data ]; then
    mkdir $MAPDIR/mariadb-data
fi

docker run -it -v ~/idc:/tmp/backup ghcr.io/jhu-sheridan-libraries/idc-isle-dc/snapshot:$SNAPSHOT_TAG sh -c "apk add rsync && rsync -avz /data/ tmp/backup/"

