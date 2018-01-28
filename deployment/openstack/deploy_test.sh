#!/bin/bash

. ./tools.sh

. ./end_test.sh # One test machine at a time

set -e

cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --security-group $GLOBAL_SECURITY_GROUP --key-name $KEY_NAME --network $PRIV_NETWORK --wait $TEST_NAME"
cmd "openstack server add floating ip $TEST_NAME $TEST_FLOATING_IP"

echo "Wait ${SSH_OPEN_DELAY}s for ssh port to open"
sleep $SSH_OPEN_DELAY

./deploy_app.sh $TEST_FLOATING_IP

if [ $? -ne 0 ]
then
	exit 1
fi

# Add test scripts dependencies
cmd_instance "sudo pip3 install requests" $TEST_FLOATING_IP
