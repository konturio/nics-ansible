# nics-ansible 
 Ansible playbooks and roles to configure and deploy NICS.

## Minimum Requirements
The system and user that launches the Ansible playbook (Ansible Controller) needs:
- [Ansible 2.10](http://docs.ansible.com/ansible/intro_installation.html) installed.
- Access to the Internet via HTTP/HTTPS to download 3rd party dependencies.
- 800MB of free space in the nics-ansible folder for 3rd part dependencies.
- Access via openssh to github.com to download the NICS git repositories to compile NICS.
- Root or 'sudo all' access to the servers you will deploy NICS on.
- If you want to automatically install the build depencies, (i.e. openjdk-8, maven, git) you will need root or 'sudo all' access on the system you are compiling NICS on.

The servers which NICS is being deployed to must use Ubuntu Server 18.04. NICS can be installed on other Linux distributions and even on Microsoft Windows but MITLL does not test or support these scenarios at this time. 

A single server deployment for testing/development expects a minimum of 2GB of memory to function properly.

## Usage

See the [STEP-BY-STEP-GUIDE](STEP-BY-STEP-GUIDE.md) for how to install and use Ansible with this repository

For the type of deployment you want to use, copy the associated playbook and vars file, modify them and run then against your servers.

```
nics-ansible
│   README.md                      
│   STEP-BY-STEP-GUIDE.md  # quickstart guide 
│   TESTING.md             # unfinished but will use molecule for testing
└───playbooks
│   │   compile.yml        # downloads, configures and compiles NICS code
│   │   distributed.yml    # deploy to 5 servers [keycloak, web, db, data/api, map]
│   │   single-server.yml  # deploy to single server
└───roles
│   │   nics-apache2       # installs apache2 and mod_auth_openidc module
│   │   nics-data          # installs NICS data/api server
│   │   nics-db            # installs NICS db server
│   │   nics-developer     # downloads, configures and compiles NICS code
│   │   nics-java          # installs openjdk 8
│   │   nics-keycloak      # installs keycloak server and database
│   │   nics-map           # installs NICS geoserver
│   │   nics-processors    # installs NICS core processors (email-consumer)
│   │   nics-single-server # unfinished for molecule vagrant testing
│   │   nics-tomcat8       # installs tomcat8
│   │   nics-web           # installs NICS web server
└───var
│   │   compile.yml        # variables for compile playbook
│   │   distributed.yml    # variables for distributed playbook
│   │   single-server.yml  # variables for single-server playbook
│   │   vault.yml          # an example ansible vault file 
```

### Configuration


**NOTE:** The `.vault_pass.txt` file is in the `.gitignore` file to prevent it from being accidentally committed. Please take great care to ensure that the password file is never committed.
