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
