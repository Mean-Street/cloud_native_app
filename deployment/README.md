On the bastion:

## Install Ansible

```
sudo ./install_ansible.sh
```

## Install Jenkins

```
sudo ./install_jenkins.sh
```

## Install OpenStack

* Set password in `ansible/group_vars/openstack`
* Customize vars in `ansible/playbooks/openstack.yml`

```
sudo ./install_openstack.sh
sudo ./run_packstack.sh
```
