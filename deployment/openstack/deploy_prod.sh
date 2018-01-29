#!/bin/bash

. ./tools.sh

set -e

cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --security-group $GLOBAL_SECURITY_GROUP --security-group $PROD_SECURITY_GROUP --key-name $KEY_NAME --network $PRIV_NETWORK --wait $PROD_NEXT_NAME"
cmd "openstack server add floating ip $PROD_NEXT_NAME $PROD_TMP_FLOATING_IP"

echo "Wait ${SSH_OPEN_DELAY}s for ssh port to open"
sleep $SSH_OPEN_DELAY

./deploy_app.sh $PROD_TMP_FLOATING_IP
exit $?
