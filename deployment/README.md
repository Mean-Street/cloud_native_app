On the bastion:

## Install bastion

```
sudo ./install_ansible.sh

sudo ./install_jenkins.sh
# TODO: do it in the playbook
sudo visudo
# Append at the end of the file:
# jenkins ALL=(ALL) NOPASSWD: ALL

sudo ./configure.sh
```

## Plug Jenkins to Github

* On GitHub: add a webhook at `http://labossi.hpintelco.net:8083/github-webhook/` on push and pull-request events
* Go to [http://10.11.53.27:8080/job/github_multibranch_pipeline/credentials/](http://10.11.53.27:8080/job/github_multibranch_pipeline/credentials/) and add credentials to github_multibranch_pipeline
* Go to [http://10.11.53.27:8080/job/github_multibranch_pipeline/configure](http://10.11.53.27:8080/job/github_multibranch_pipeline/configure) and select the credentials you've just created ("Branch Sources" section)

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
