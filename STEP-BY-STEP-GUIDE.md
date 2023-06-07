# UNFINISHED

# A Step-By-Step Guide to using the nics-ansible playbooks

This guide will show you how to run the ansible dev-playbook for a development desktop/server on Ubuntu 18.04. This playbook will compile, install and configure NICS components for development.

### Installing Ansible
There are many different options to install Ansible, at this time we are supporting Ansible 2.10 (ansible-base 2.10).

### Ubuntu 18.04/20.04 using Ansible's Ubuntu PPA
```bash
sudo apt update && sudo apt upgrade && sudo systemctl reboot
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Install additional packages
```bash
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt update
sudo apt install -y git gzip unzip maven nodejs
```

### Get a copy of nics-ansible playbooks. There are two ways to get a copy:

  - Download the [ZIP file](https://github.com/NATO-NICS/nics-ansible/archive/master.zip). Unzip the file to create a directory named `nics-ansible-master` containing the nics-ansible playbooks.

  - Run the commands `apt install -y git && git clone https://github.com/NATO-NICS/nics-ansible.git` to create a directory named `nics-ansible` containing the nics-ansible playbooks.

### Compile NICS repositories 

Run the compile.yml playbook from the system that will be installing NICS from, this can be the same server that the single-server playbook will run from.

`ansible-playbook playbooks/compile.yml -K`

If you don't need a password to run 'sudo' you can use this command.

`ansible-playbook playbooks/compile.yml`


### Edit variables for installing NICS
You will need to modify the some of the variables inside ./vars/single-server.yml or ./vars/distributed.yml.
- The single-server playbook installs NICS to a single server. 
- The distributed playbook installs to multiple servers, one for each role.

These playbooks assume the user who is logging in and using ssh has sudo rights to root without using a password. One may remove this requirement after installation. There was a problem that was not resolved with large folder synchronization without have sudo w/nopasswd.

### Ensure the hosts file is configured for ansible
If you are running the single-server playbook, ensure you have a hosts file that contains [nics] with the system you are installing NICS to.
If you are running the distributed playbook ensure you have a hosts file that contains [web], [data], [db], [map] and [identity]. 

### Run the ansible playbook
Example command to run the single-server playbook.
`ansible-playbook -i inventory.yml playbook/single-server.yml -vvv`

inventory.yml example for single-server:
```
[nics]
<fully qualified domain name>
```
