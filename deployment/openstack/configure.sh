#!/bin/bash

set -e

. ./tools.sh

# Add Ubuntu image
curl -O http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
glance image-create --name "Ubuntu" --disk-format qcow2 --container-format bare --visibility public --file xenial-server-cloudimg-amd64-disk1
rm -f http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img

# Create public network
cmd "neutron net-create public --router:external --provider:network_type vlan --provider:physical_network extnet --provider:segmentation_id 2232"
cmd "neutron subnet-create --name public-subnet --enable_dhcp=False --allocation-pool=start=10.11.54.50,end=10.11.54.69 --gateway=10.11.54.1 $PUB_NETWORK 10.11.54.1/24"

# Create stack
scp -i $CONTROLLER_PRIV_KEY $HEAT_TEMPLATE root@$CONTROLLER_IP:~/$HEAT_TEMPLATE
stack_args="--parameter 'ssh_key_param=$KEY_NAME;private_network_param=$PRIV_NETWORK;public_network_param=$PUB_NETWORK;global_security_group_param=$GLOBAL_SECURITY_GROUP;prod_security_group_param=$PROD_SECURITY_GROUP;test_floating_ip_param=$TEST_FLOATING_IP;prod_floating_ip_param=$PROD_FLOATING_IP;prod_tmp_floating_ip=$PROD_TMP_FLOATING_IP' -t $HEAT_TEMPLATE $STACK_NAME"
cmd "openstack stack delete -y --wait $STACK_NAME"
cmd "openstack stack create $stack_args"

. ./get_private_key.sh
