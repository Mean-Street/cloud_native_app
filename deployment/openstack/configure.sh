#!/bin/bash

. ./config.sh

# Key pair
scp -i "$CONTROLLER_PRIV_KEY" "$PUB_KEY_PATH" root@$CONTROLLER_IP:"${KEY_NAME}.pub"
cmd "openstack keypair create --public-key ${KEY_NAME}.pub $KEY_NAME"

# Floating ips
cmd "openstack floating ip create --floating-ip-address $TEST_FLOATING_IP $PUB_NETWORK"
cmd "openstack floating ip create --floating-ip-address $PROD_FLOATING_IP $PUB_NETWORK"
