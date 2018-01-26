#!/bin/bash

CONFIG_FILE=~/cloud_native_app/deployment/openstack/config.sh
TEST_FILE=~/cloud_native_app/tests/run_tests.py

source $CONFIG_FILE
echo $PRIV_KEY_PATH $SSH_USER@$TEST_FLOATING_IP
ssh -i $PRIV_KEY_PATH $SSH_USER@$TEST_FLOATING_IP python3 $TEST_FILE

