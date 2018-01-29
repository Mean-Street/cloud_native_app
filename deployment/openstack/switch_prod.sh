#!/bin/bash

set -e

. ./tools.sh

cmd "openstack server remove floating ip $PROD_NEXT_NAME $PROD_TMP_FLOATING_IP"
cmd "openstack server add floating ip $PROD_NEXT_NAME $PROD_FLOATING_IP"

cmd "openstack server delete --wait $PROD_NAME"
cmd "openstack server set --name $PROD_NEXT_NAME $PROD_NAME"
