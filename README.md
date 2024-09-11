# Setup for OpenStack instance deployment via Ansible

Let's use this Ansible setup to demonstrate, how to customize a bwCloud instance.


## Requirements

- A created, running and accessible VM in the bwCloud, e. g. `vm01`.
  The image of this machine is a 'Debian' version.
  Assume the private SSH-Key file is `~/.ssh/my_key`.
- A local installation of [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html).


## First steps

0. This guide is part of the [bwCloud tutorial](https://www.bw-cloud.org/en/bwcloud_scope/use).
1. Clone this repo onto your local machine.
   `git clone https://github.com/bwCloud/ansible-template.git`
2. Rename and enter the template.
   `mv ansible-template myAnsible & cd myAnsible`
3. Set your secret password in `./ansible.pass`.
   You can create a new one with: `openssl rand -hex 16`
4. Replace the TODOs in `./inventories/hosts.ini` with the data for `vm01`.
5. Replace the TODOs in `./inventories/host_vars/vm01/host.yml`.
   See below for more information about the file structure.
6. Test the setup.
   `make test`
6. Read the rest of this document.


## Second steps

7. Replace the TODOs in `./inventories/group_vars/bwCloud/openstack_client_creds.yml`.
   Use the values from your application credentials.
   [Here](https://www.bw-cloud.org/en/faq/access) you find help for generating these.
8. Encrypt the `openstack_client` credentials with your `./ansible.pass`.
   `ansible-vault encrypt ./inventories/group_vars/bwCloud/openstack_client_creds.yml`
9. Update the package cache of your instances in the `bwCloud` *group*. Run therefore the *role* `apt`.
   `make run TAG=apt`
10. Set up your instance via auto-deployment.
   `make run`

### What happened

We quickly prepared our instance `vm01` for further usage.

- By using root privileges, the `virtuelenv` package was installed.
  Some other useful packages had been installed.
  Take a look into `./roles/basics/tasks/install.yml`.
- The python OpenStack client had been installed into a created virtual environment.
  Also, your application credential is placed on the *vm01*.
  Take a look into it `~/.os_creds.sh`.
- Your `PATH` environment variable points to the virtual python environment.
  Take a look:
  ```
  echo $PATH
  ```
- Log in, into your instance `vm01` and run the following commands.
  ```
  source ~/.os_creds.sh && openstack server list
  ```
  You should see a list of your instances.

- We also told the instance, to resolve its domain name.
  Check this in `/etc/hosts`.


## And now
Edit the *roles* or add new ones. Customize your instance with Ansible.


## About the file structure

- `./inventories/hosts.ini`: Mange the *groups* of your VMs.
- `./inventories/host_vars/vm01`: The most atomic information/ *variables* about your VM.
   The directory `./inventories/host_vars/vm01` matches to the host `vm01` in the `./inventories/hosts.ini` file.
- `./inventories/group_vars/bwCloud`: The variable, grouped by *roles*, controlling the customization of the bwCloud VMs.
- `./roles`: The actions, grouped by *roles*, customizing your bwCloud VMs.
- `./playbooks`: The (ordered) collection of the *roles*.

