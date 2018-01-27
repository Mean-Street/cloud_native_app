#!/bin/bash

. ./config.sh

cmd "openstack server remove floating ip $PROD_OLD_NAME $PROD_FLOATING_IP"
cmd "openstack server add floating ip $PROD_NAME $PROD_FLOATING_IP"

cmd "openstack server delete --wait $PROD_OLD_NAME"
