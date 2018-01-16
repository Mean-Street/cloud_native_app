#!/bin/bash

ansible-galaxy install geerlingguy.jenkins geerlingguy.pip
ansible-playbook playbooks/jenkins.yml --connection=local
