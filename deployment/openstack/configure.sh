#!/bin/bash

. ./config.sh

# Add Ubuntu image
curl -O http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
glance image-create --name "Ubuntu" --disk-format qcow2 --container-format bare --visibility public --file xenial-server-cloudimg-amd64-disk1
rm -f http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img

# Create public network
neutron net-create public --router:external --provider:network_type vlan --provider:physical_network extnet --provider:segmentation_id 2232
neutron subnet-create --name public-subnet --enable_dhcp=False --allocation-pool=start=10.11.54.50,end=10.11.54.69 --gateway=10.11.54.1 public 10.11.54.1/24

# Create stack
scp -i $CONTROLLER_PRIV_KEY $HEAT_TEMPLATE root@$CONTROLLER_IP:~/$HEAT_TEMPLATE
cmd "openstack stack create -t $HEAT_TEMPLATE $STACK_NAME"
cmd "openstack stack update -t $HEAT_TEMPLATE $STACK_NAME"

. ./get_private_key.sh








# TODO: to be removed
exit 0

# Key pair
cmd "openstack keypair delete $KEY_NAME"
rm -f $PRIV_KEY_PATH
cmd "openstack keypair create $KEY_NAME" false > $PRIV_KEY_PATH
chmod 400 $PRIV_KEY_PATH

# Floating ips
cmd "openstack floating ip create --floating-ip-address $TEST_FLOATING_IP $PUB_NETWORK"
cmd "openstack floating ip create --floating-ip-address $PROD_FLOATING_IP $PUB_NETWORK"

# Security groups
cmd "openstack security group show $GLOBAL_SECURITY_GROUP"
if [ $? -ne 0 ]; then
    cmd "openstack security group create $GLOBAL_SECURITY_GROUP"
fi
cmd "openstack security group show $PROD_SECURITY_GROUP"
if [ $? -ne 0 ]; then
    cmd "openstack security group create $PROD_SECURITY_GROUP"
fi

cmd "openstack security group rule create --dst-port 22:22 --ingress $GLOBAL_SECURITY_GROUP"
cmd "openstack security group rule create --ingress --protocol icmp $GLOBAL_SECURITY_GROUP"

cmd "openstack security group rule create --dst-port 80:80 --ingress $PROD_SECURITY_GROUP"
cmd "openstack security group rule create --dst-port 443:443 --ingress $PROD_SECURITY_GROUP"
