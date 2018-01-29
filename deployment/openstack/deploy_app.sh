#!/bin/bash

IP=$1

. ./tools.sh

./init_instance.sh $IP
if [ $? -ne 0 ]
then
    exit 1
fi

cmd_instance "cd cloud_native_app; git pull" $IP

i=0
err=1
while [ $err -ne 0 -a $i -lt $DOCKER_COMPOSE_MAX_REPEAT ]
do
    i=`expr $i + 1`
	echo "[ $i / $DOCKER_COMPOSE_MAX_REPEAT ]"
    cmd_instance "sudo docker-compose -f ./cloud_native_app/docker-compose.yml up -d" $IP
    err=$?
	echo "[DEBUG]Result = $err"
done

exit $err
