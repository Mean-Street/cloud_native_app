On the bastion:

## Install Ansible

```
sudo ./install_ansible.sh
```

## Install Jenkins

```
ansible-galaxy install geerlingguy.jenkins
sudo ansible-playbook playbooks/jenkins.yml --connection=local

# Create job
sudo cp jenkins/jobs.ini /etc/jenkins_jobs/jenkins_jobs.ini
sudo install_pip.sh
pip install --user jenkins-job-builder
sudo jenkins-jobs update jenkins/github.yml
```
