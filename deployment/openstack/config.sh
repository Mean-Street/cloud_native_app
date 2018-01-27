#!/bin/bash

export CONFIG_DIR=/opt/config
export CONTROLLER_IP=10.11.51.142
export CONTROLLER_PRIV_KEY="$CONFIG_DIR/controller.pem"

function cmd {
    # In case where we want to read the crude ssh output
    if [ -z "$2" ]; then
        echo $1
    fi
    ssh -o StrictHostKeyChecking=no -i "$CONTROLLER_PRIV_KEY" root@$CONTROLLER_IP ". ./config_files/keystonerc_admin; $1"
}

# Global
export HEAT_TEMPLATE=heat.yml
export STACK_NAME=cloud_native_app_stack
export IMAGE_ID="Ubuntu"
export FLAVOR_ID="m1.small"
export PUB_NETWORK="public"
export PRIV_NETWORK="private"
export KEY_NAME=server
export PRIV_KEY_PATH="$CONFIG_DIR/server.pem"
export GLOBAL_SECURITY_GROUP=global_security_group
export SSH_USER=ubuntu

# Test instance
export TEST_FLOATING_IP="10.11.54.61"
export TEST_NAME=testinstance

# Prod instance
export PROD_FLOATING_IP="10.11.54.63"
export PROD_OLD_NAME="oldprodinstance"
export PROD_NAME="prodinstance"
export PROD_SECURITY_GROUP=prod_security_group
