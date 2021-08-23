#!/bin/bash

IDC_DIR=/tmp/idc
SNAPSHOT="ghcr.io/jhu-sheridan-libraries/idc-isle-dc/snapshot:upstream-20201007-739693ae-299-g2877508.1622573315"
echo 
echo "This script will create an idc data store in $IDC_DIR.  Change the IDC_DIR variable to move this."
echo "Make sure you update the File Sharing in Docker Desktop if you change this."
echo; echo "Press any key to continue. (or wait 10 seconds)"
read -n1 junk

mkdir -p $IDC_DIR/

cd $IDC_DIR

DOCKER=`which docker`
if [ -z $DOCKER ]
then
  echo "Error: Docker is not in your PATH.  Is something wrong with your docker desktop setup?" >&2
  exit 1
fi

echo -e "I'm going to use \n\t$SNAPSHOT\nto build an initial setup.  Ctrl-C now to change it. (Sleep 10 seconds)"

sleep 10

snapshot=$(docker create $SNAPSHOT); \
docker export $snapshot > data.tar

tar -xf data.tar data/
if [ "$?" != "0" ]
then  
  echo "Error: couldn't extract the snapshot." >&2
  exit 1
fi
rm -f data.tar

mv data/* ./
rm -rf data/
mkdir -p {activemq-data,cantaloupe-data,etcd-data}