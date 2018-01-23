#!/bin/sh

ansible-playbook -i ansible/hosts ansible/playbooks/openstack-install.yml
