#!/bin/bash

# Do not use set -e as the prod instance may not exist and its deleting may fail

. ./tools.sh

cmd "openstack server remove floating ip $PROD_NEXT_NAME $PROD_TMP_FLOATING_IP"
if [ $? -ne 0 ]; then
    exit 1
fi

cmd "openstack server add floating ip $PROD_NEXT_NAME $PROD_FLOATING_IP"
if [ $? -ne 0 ]; then
    exit 1
fi

cmd "openstack server delete --wait $PROD_NAME"
cmd "openstack server set --name $PROD_NAME $PROD_NEXT_NAME"
exit $?
