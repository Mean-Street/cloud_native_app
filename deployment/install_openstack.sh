#!/bin/sh

ansible-playbook -e 'host_key_checking=False' playbooks/openstack.yml
