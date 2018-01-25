On the bastion:

## Install Ansible

```
sudo ./install_ansible.sh
```

## Install Jenkins

```
sudo ./install_jenkins.sh
sudo visudo
# Append at the end of the file:
# jenkins ALL=(ALL) NOPASSWD: ALL
```

## Install OpenStack

* Customize vars in `ansible/playbooks/openstack.yml`

```
sudo ./install_openstack.sh
```

To run packstack on a machine A (here, the controller), this machine
must be able to connect to the controller and to the compute through ssh without password. Packstack
uses the key `~/.ssh/id_rsa`. Make sure the following commands work and do not ask any password:

```
ssh root@controller_ip
ssh root@compute_ip
```

Then, on this machine:

```
sudo ./run_packstack.sh
```

```
cd openstack
export CONTROLLER_IP=10.11.51.142; ./configure.sh
```
