On the bastion:

## Install Ansible

```
sudo ./install_ansible.sh
sudo cat ansible_hosts > /etc/ansible/hosts
```

## Install Jenkins

```
ansible-galaxy install geerlingguy.jenkins
ansible-playbook playbooks/jenkins.yml
```
