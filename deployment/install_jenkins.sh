#!/bin/bash

ansible-galaxy install geerlingguy.jenkins geerlingguy.pip
ansible-playbook -i ansible/hosts ansible/playbooks/jenkins.yml --connection=local
