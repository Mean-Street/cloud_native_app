#!/bin/bash

set -e

IP=$1

. ./tools.sh

cmd_instance "sudo sh -c 'echo nameserver 8.8.8.8 > /etc/resolv.conf'" $IP
cmd_instance "sudo sh -c 'echo LANG=en_US.utf-8 > /etc/environment'" $IP
cmd_instance "sudo sh -c 'echo LC_ALL=en_US.utf-8 >> /etc/environment'" $IP

cmd_instance "sudo apt-get -y update" $IP
cmd_instance "sudo apt-get -y upgrade" $IP
cmd_instance "sudo apt-get -y install git docker.io python3-pip" $IP
cmd_instance "sudo pip3 install --upgrade pip" $IP
cmd_instance "sudo pip3 install docker-compose" $IP

cmd_instance "sudo systemctl start docker" $IP
cmd_instance "git clone https://github.com/Mean-Street/cloud_native_app" $IP

i=0
err=0
while [ $err -eq 0 -a $i -lt $DOCKER_COMPOSE_MAX_REPEAT ]
do
    i=`expr $i + 1`
    cmd_instance "sudo docker-compose -f ./cloud_native_app/docker-compose.yml up -d" $IP
    err=$?
done
