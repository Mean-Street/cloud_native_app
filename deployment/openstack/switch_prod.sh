#!/bin/bash

set -e

. ./tools.sh

cmd "openstack server remove floating ip $PROD_NAME $PROD_TMP_FLOATING_IP"
cmd "openstack server add floating ip $PROD_NAME $PROD_FLOATING_IP"

cmd "openstack server delete --wait $PROD_OLD_NAME"
