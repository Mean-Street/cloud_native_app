#!/bin/bash

. ./tools.sh

cmd "openstack server set --name $PROD_OLD_NAME $PROD_NAME"
cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --security-group $GLOBAL_SECURITY_GROUP --security-group $PROD_SECURITY_GROUP --key-name $KEY_NAME --network $PRIV_NETWORK --wait $PROD_NAME"

. ./deploy_app.sh $PROD_FLOATING_IP
