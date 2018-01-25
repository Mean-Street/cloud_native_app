#!/bin/bash

. ./config.sh

# Key pair
cmd "openstack keypair delete $KEY_NAME"
rm -f $PRIV_KEY_PATH
cmd "openstack keypair create $KEY_NAME" false > $PRIV_KEY_PATH
chmod 400 $PRIV_KEY_PATH

# Floating ips
cmd "openstack floating ip create --floating-ip-address $TEST_FLOATING_IP $PUB_NETWORK"
cmd "openstack floating ip create --floating-ip-address $PROD_FLOATING_IP $PUB_NETWORK"

# Security groups
cmd "openstack security group show $GLOBAL_SECURITY_GROUP"
if [ $? -ne 0 ]; then
    cmd "openstack security group create $GLOBAL_SECURITY_GROUP"
fi
cmd "openstack security group show $PROD_SECURITY_GROUP"
if [ $? -ne 0 ]; then
    cmd "openstack security group create $PROD_SECURITY_GROUP"
fi

cmd "openstack security group rule create --dst-port 22:22 --ingress $GLOBAL_SECURITY_GROUP"
cmd "openstack security group rule create --ingress --protocol icmp $GLOBAL_SECURITY_GROUP"

cmd "openstack security group rule create --dst-port 80:80 --ingress $PROD_SECURITY_GROUP"
cmd "openstack security group rule create --dst-port 443:443 --ingress $PROD_SECURITY_GROUP"
