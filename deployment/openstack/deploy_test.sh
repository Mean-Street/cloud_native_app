#!/bin/bash

. ./tools.sh

. ./end_test.sh # One test machine at a time

cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --security-group $GLOBAL_SECURITY_GROUP --key-name $KEY_NAME --network $PRIV_NETWORK --wait $TEST_NAME"
cmd "openstack server add floating ip $TEST_NAME $TEST_FLOATING_IP"

. ./deploy_app.sh $TEST_FLOATING_IP
