# Setup for OpenStack instance deployment via Ansible


## Requirements
* A created, running and accessible VM in the bwCloud, e. g. `vm01`.
  The image of this machine is a 'Debian' version.
  Assume the private SSH-Keyfile is `~/.ssh/my_key`.
* A local installation of [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html).


## First steps
0. This guide is part of the [bwCloud tutorial](https://www.bw-cloud.org/en/bwcloud_scope/use).
1. Clone this repo.
   `git clone https://github.com/bwCloud/ansible-template.git`
2. Rename and enter the template.
   `mv ansible-template myAnsible & cd myAnsible`
2. Set your secret password in `./ansible.pass`.
3. Replace the TODOs in `./inventories/hosts.ini` with the data for `vm01`.
4. Replace the TODOs in `./inventories/host_vars/vm01/host.yml`
5. Test the setup.
   `make test`
6. Read the rest of this document.


## Second steps
7. Replace the TODOs in `./inventories/group_vars/bwCloud/openstack_client_creds.yml`
8. Encrypt the `openstack_client` credentials with your `./ansible.pass`.
   `ansible-vault encrypt ./inventories/group_vars/bwCloud/openstack_client_creds.yml`
9. Update the package cache of your instances in the `bwCloud` *group*. Run therefore the *role* `apt`.
   `make run TAG=apt`
10. Set up your instance via auto-deployment.
   `make run`


## And now
11. Read `./roles/openstack_client/README.md` to connect with OpenStack.
12. Edit the *roles* or add new ones. Customize your instance with Ansible.


## About the file structure
* `./inventories/hosts.ini`: Mange the *groups* of your VMs.
* `./inventories/host_vars/vm01`: The most atomic information/ *variables* about your VM.
* `./inventories/group_vars/bwCloud`: The variable, grouped by *roles*, controlling the customization of the bwCloud VMs.
* `./roles`: The actions, grouped by *roles*, customizing your bwCloud VMs.
* `./playbooks/`: The (ordered) collection of the *roles*.

