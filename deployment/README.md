On the bastion:

## Install Ansible

```
sudo ./install_ansible.sh
cat ansible_hosts | sudo tee /etc/ansible/hosts
```

## Install Jenkins

```
ansible-galaxy install geerlingguy.jenkins
ansible-playbook playbooks/jenkins.yml --connection=local
```
