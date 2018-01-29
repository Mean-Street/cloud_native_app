#!/bin/bash

export CONFIG_DIR=/opt/config
export CONTROLLER_IP=10.11.51.142
export CONTROLLER_PRIV_KEY="$CONFIG_DIR/controller.pem"

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
export SSH_OPEN_DELAY=50
export DOCKER_COMPOSE_MAX_REPEAT=10

# Test instance
export TEST_FLOATING_IP="10.11.54.61"
export TEST_NAME=testinstance

# Prod instance
export PROD_TMP_FLOATING_IP="10.11.54.63"
export PROD_FLOATING_IP="10.11.54.54"
export PROD_OLD_NAME="oldprodinstance"
export PROD_NAME="prodinstance"
export PROD_SECURITY_GROUP=prod_security_group
