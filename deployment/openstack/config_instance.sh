#!/bin/sh

# Setting up default settings
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo sh -c 'echo "LANG=en_US.utf-8" > /etc/environment'
sudo sh -c 'echo "LC_ALL=en_US.utf-8" >> /etc/environment'

# Updating
sudo apt-get -y update

# Installing needed packages
sudo apt-get -y install git docker.io python-pip
sudo pip install --upgrade pip
sudo pip install docker-compose

# Setting up the project
sudo systemctl start docker
git clone https://github.com/Mean-Street/cloud_native_app /home/ubuntu/cloud_native_app
sudo docker-compose -f /home/ubuntu/cloud_native_app/docker-compose.yml up
