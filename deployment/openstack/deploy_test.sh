#!/bin/bash

. ./config.sh

cmd "openstack server delete --wait $TEST_NAME"
cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --key-name $KEY_NAME --nic net-id=$PRIV_NETWORK,v4-fixed-ip=$TEST_FIXED_IP --wait $TEST_NAME"
cmd "openstack server add floating ip --fixed-ip-address $TEST_FIXED_IP $TEST_NAME $TEST_FLOATING_IP"

. ./deploy_app.sh $TEST_FLOATING_IP $PRIV_KEY_PATH
