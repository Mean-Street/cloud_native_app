#!/bin/bash

# To be defined as env var
# CONTROLLER_IP=$1
CONTROLLER_PRIV_KEY=~/controller.pem

function cmd {
    # In case where we want to read the crude ssh output
    if [ -z "$2" ]; then
        echo $1
    fi
    ssh -i "$CONTROLLER_PRIV_KEY" root@$CONTROLLER_IP ". ./config_files/keystonerc_admin; $1"
}

# Global
IMAGE_ID="Ubuntu"
FLAVOR_ID="m1.small"
PUB_NETWORK="public"
PRIV_NETWORK="9ed0ebaa-3b02-4559-92e9-c99b06f51bc1"
KEY_NAME=server
PRIV_KEY_PATH=~/server.pem

# Test instance
TEST_FLOATING_IP="10.11.54.61"
TEST_NAME=testinstance

# Prod instance
PROD_FLOATING_IP="10.11.54.63"
PROD_OLD_NAME="oldprodinstance"
PROD_NAME="prodinstance"
