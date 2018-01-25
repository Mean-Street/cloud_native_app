#!/bin/bash

. ./config.sh

cmd "openstack server set --name $PROD_OLD_NAME $PROD_NAME"
cmd "openstack server create --image $IMAGE_ID --flavor $FLAVOR_ID --security-group $GLOBAL_SECURITY_GROUP --security-group $PROD_SECURITY_GROUP --key-name $KEY_NAME --network $PRIV_NETWORK --wait $PROD_NAME"

cmd "openstack server remove floating ip $PROD_OLD_NAME $PROD_FLOATING_IP"
cmd "openstack server add floating ip $PROD_NAME $PROD_FLOATING_IP"

. ./deploy_app.sh $PROD_NAME $PRIV_KEY_PATH

echo "TODO: make sure the app is correctly deployed"

cmd "openstack server delete --wait $PROD_OLD_NAME"
