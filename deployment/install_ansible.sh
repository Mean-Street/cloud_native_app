#!/bin/bash

apt-get update
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
cat ansible_hosts | tee /etc/ansible/hosts
