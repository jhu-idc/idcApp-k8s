#!/bin/bash

MAPDIR=~/idc

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

docker run -it -v ~/idc:/tmp/backup ghcr.io/jhu-sheridan-libraries/idc-isle-dc/snapshot:upstream-20201007-739693ae-139-g94f8bba.1610738096 sh -c "apk add rsync && rsync -avz /data/mariadb-files /data/solr /data/drupal tmp/backup"

