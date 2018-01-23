#!/bin/sh

ansible-playbook -i ansible/hosts -e 'host_key_checking=False' ansible/playbooks/openstack.yml
