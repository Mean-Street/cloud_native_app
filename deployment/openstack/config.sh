#!/bin/bash

# To be defined as env var
# CONTROLLER_IP=$1
CONTROLLER_PRIV_KEY=~/controller.pem

function cmd {
    echo $1
    ssh -i "$CONTROLLER_PRIV_KEY" root@$CONTROLLER_IP ". ./config_files/keystonerc_admin; $1"
}

# Global
IMAGE_ID="Ubuntu"
FLAVOR_ID="m1.small"
PUB_NETWORK="public"
PRIV_NETWORK="9ed0ebaa-3b02-4559-92e9-c99b06f51bc1"
KEY_NAME=server
PUB_KEY_PATH=~/server.pub

# Test instance
TEST_FIXED_IP="192.168.0.17"
TEST_FLOATING_IP="10.11.54.61"

# Prod instance
PROD_FLOATING_IP="10.11.54.63"
