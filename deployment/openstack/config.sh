#!/bin/bash

CONTROLLER_IP=10.11.51.142
CONTROLLER_PRIV_KEY=~/controller.pem

function cmd {
    # In case where we want to read the crude ssh output
    if [ -z "$2" ]; then
        echo $1
    fi
    ssh -i "$CONTROLLER_PRIV_KEY" root@$CONTROLLER_IP ". ./config_files/keystonerc_admin; $1"
}

# Global
HEAT_TEMPLATE=heat.yml
STACK_NAME=cloud_native_app_stack
IMAGE_ID="Ubuntu"
FLAVOR_ID="m1.small"
PUB_NETWORK="public"
PRIV_NETWORK="private"
KEY_NAME=server
PRIV_KEY_PATH=~/server.pem
GLOBAL_SECURITY_GROUP=global_security_group
SSH_USER=ubuntu

# Test instance
TEST_FLOATING_IP="10.11.54.61"
TEST_NAME=testinstance

# Prod instance
PROD_FLOATING_IP="10.11.54.63"
PROD_OLD_NAME="oldprodinstance"
PROD_NAME="prodinstance"
PROD_SECURITY_GROUP=prod_security_group
