#!/bin/bash

echo "TODO: create an ansible playbook"

. ./openstack/config.sh

GROUP=hpe

groupadd $GROUP
usermod -a -G $GROUP ubuntu
usermod -a -G $GROUP jenkins
git clone https://github.com/Mean-Street/CloudHP $CONFIG_DIR
chown -R ubuntu $CONFIG_DIR
chgrp -R $GROUP $CONFIG_DIR
chmod -R g+rw $CONFIG_DIR
