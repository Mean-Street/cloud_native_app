#!/bin/sh

# Getting the server updated
echo "Updating CentOS server..."
sudo yum -y update

# Getting the right environment language
echo "Checking environment language..."
envir_file="/etc/environment"
echo "LANG=en_US.utf-8" > $envir_file
echo "LC_ALL=en_US.utf-8" >> $envir_file

# Installing packstack
echo "Installing packstack packages..."
sudo yum install -y centos-release-openstack-pike
sudo yum -y update
sudo yum install -y openstack-packstack

# Generating answer file
echo "Getting the answer configuration file"
sudo packstack --gen-answer-file=answers.txt
if grep "CONFIG_NTP_SERVERS=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NTP_SERVERS=/s/.*/CONFIG_NTP_SERVERS=10.3.252.26/' ensimag-packstack.txt
else
	echo "CONFIG_NTP_SERVERS=10.3.252.26" >> ensimag-packstack.txt
fi
if grep "CONFIG_NEUTRON_ML2_TYPE_DRIVERS=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NEUTRON_ML2_TYPE_DRIVERS=/s/.*/CONFIG_NEUTRON_ML2_TYPE_DRIVERS=vxlan,flat,vlan/' ensimag-packstack.txt
else
	echo "CONFIG_NEUTRON_ML2_TYPE_DRIVERS=vxlan,flat,vlan" >> ensimag-packstack.txt
fi
if grep "CONFIG_NEUTRON_ML2_FLAT_NETWORKS=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NEUTRON_ML2_FLAT_NETWORKS=/s/.*/CONFIG_NEUTRON_ML2_FLAT_NETWORKS=extnet/' ensimag-packstack.txt
else
	echo "CONFIG_NEUTRON_ML2_FLAT_NETWORKS=extnet" >> ensimag-packstack.txt
fi
if grep "CONFIG_NEUTRON_ML2_VLAN_RANGES=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NEUTRON_ML2_VLAN_RANGES=/s/.*/CONFIG_NEUTRON_ML2_VLAN_RANGES=extnet:2232:2232/' ensimag-packstack.txt
else
	echo "CONFIG_NEUTRON_ML2_VLAN_RANGES=extnet:2232:2232" >> ensimag-packstack.txt
fi
if grep "CONFIG_NTP_SERVERS=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NTP_SERVERS=/s/.*/CONFIG_NTP_SERVERS=10.3.252.26/' ensimag-packstack.txt
else
	echo "CONFIG_NTP_SERVERS=10.3.252.26" >> ensimag-packstack.txt
fi
if grep "CONFIG_NEUTRON_OVS_BRIDGE_IFACES=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NEUTRON_OVS_BRIDGE_IFACES=/s/.*/CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eno1/' ensimag-packstack.txt
else
	echo "CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eno1" >> ensimag-packstack.txt
fi
if grep "CONFIG_NEUTRON_OVS_BRIDGES_COMPUTE=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_NEUTRON_OVS_BRIDGES_COMPUTE=/s/.*/CONFIG_NEUTRON_OVS_BRIDGES_COMPUTE=br-ex/' ensimag-packstack.txt
else
	echo "CONFIG_NEUTRON_OVS_BRIDGES_COMPUTE=br-ex" >> ensimag-packstack.txt
fi
if grep "CONFIG_PROVISION_DEMO=" "ensimag-packstack.txt"; then
	sed -i'.bak' '/CONFIG_PROVISION_DEMO=/s/.*/CONFIG_PROVISION_DEMO=n/' ensimag-packstack.txt
else
	echo "CONFIG_PROVISION_DEMO=n" >> ensimag-packstack.txt
fi

# Useful packages (used to be able to launch neutron command)
sudo yum install -y python-openstackclient

# Deploy packstack
sudo packstack --answer-file=ensimag-packstack.txt

# Connecting with external network
echo "Configuring connection with external network..."
neutron net-create public --router:external --provider:network_type vlan --provider:physical_network extnet --provider:segmentation_id 2232
neutron subnet-create --name public-subnet --enable_dhcp=False --allocation-pool=start=10.11.54.50,end=10.11.54.69 --gateway=10.11.54.1 public 10.11.54.1/24
echo "Configuration finished!"

# Install Ansible
echo "Installing ansible"
sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y ansible



