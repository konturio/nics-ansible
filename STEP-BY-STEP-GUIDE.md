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

### Generate an SSH key (local ansible run, on the server)
```bash 
# Press 'Enter' for all questions
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### Get a copy of nics-ansible playbooks. There are two ways to get a copy:

  - Download the [ZIP file](https://github.com/NATO-NICS/nics-ansible/archive/master.zip) (while chnages are not in upstream use Kontur repository [ZIP file](https://github.com/konturio/nics-ansible/archive/refs/heads/main.zip)). Unzip the file to create a directory named `nics-ansible-master` containing the nics-ansible playbooks.

  - Run the commands `git clone https://github.com/NATO-NICS/nics-ansible.git` (while changes are not in upstream use Kontur repository `git clone https://github.com/konturio/nics-ansible.git`) to create a directory named `nics-ansible` containing the nics-ansible playbooks.

### Edit variables for installing NICS
You will need to modify some of the variables inside `./nics-ansible/vars/single-server.yml` or `./nics-ansible/vars/distributed.yml.`
- The single-server playbook installs NICS to a single server. 
- The distributed playbook installs to multiple servers, one for each role.

Single-server config:
1. `nics_alias_fqdn`, `nics_web_fqdn`, `nics_data_fqdn`, `nics_map_fqdn`, `nics_keycloak_fqdn`, `nics_cookie_domain` - fully qualified domain name of the server
2. `nics_keycloak_nics_realm_admin_password` - password of Keycloak NICS realm admin user
3. `nics_keycloak_initial_master_realm_username` - username of Keycloak master realm admin user
4. `nics_keycloak_initial_master_realm_password` - password of Keycloak master realm admin user
5. `nics_intial_nics_account` - username of initial NICS user
6. `nics_intial_nics_password` - password of initial NICS user 
7. `nics_keycloak_db_username` - username of Keyckoak DB user
8. `nics_keycloak_db_password` - password of Keycloak DB user
9. `nics_db_password` - password of NICS DB user
10. `nics_geoserver_password` - password of Geoserver admin user

You'll also need to modify `./nics-ansible/vars/compile.yml`:
1. `nics_ui_fqdn` - fully qualified domain name of the NICS administration UI

These playbooks assume the user who is logging in and using ssh has sudo rights to root without using a password. One may remove this requirement after installation. There was a problem that was not resolved with large folder synchronization without have sudo w/nopasswd.

### Ensure the hosts file is configured for ansible
If you are running the single-server playbook, ensure you have a hosts (`inventory.yml`) file that contains [nics] with the system you are installing NICS to.
If you are running the distributed playbook ensure you have a hosts file that contains [web], [data], [db], [map] and [identity]. 

Create `inventory.yml` file in the `nics-ansible` directory root. Example for single-server:
```
[nics]
<fully qualified domain name>
```

### Compile NICS repositories

Run the compile.yml playbook from the system that will be installing NICS from, this can be the same server that the single-server playbook will run from. Run the command from the `nics-ansible` directory root.

`ansible-playbook playbooks/compile.yml -K`

If you don't need a password to run 'sudo' you can use this command.

`ansible-playbook playbooks/compile.yml`

### Run the ansible playbook
Example command to run the single-server playbook.
Run the command from the `nics-ansible` directory root.

`ansible-playbook -i inventory.yml playbook/single-server.yml -vvv`

inventory.yml example for single-server:
```
[nics]
<fully qualified domain name>
```
