#!/bin/bash

. ./config.sh

cmd "openstack server delete --wait $TEST_NAME"
cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --key-name $KEY_NAME --network $PRIV_NETWORK --wait $TEST_NAME"
cmd "openstack server add floating ip $TEST_NAME $TEST_FLOATING_IP"

. ./deploy_app.sh $TEST_FLOATING_IP $PRIV_KEY_PATH
