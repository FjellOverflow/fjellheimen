# Setting up host

The homeserver is intended to run on Fedora. Installing a fresh Fedora Server Edition is precondition to applying this setup.


## Usage

The server is set up with [Ansible](https://docs.ansible.com/ansible/latest/index.html). The provided playbook will first pull and run a role from a more general opinionated [ansible-fedora-setup](https://github.com/FjellOverflow/ansible-fedora-setup) and then run some custom tasks in addition.

1. [Install Ansible]((https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)) on workstation

2. Create `hosts.yaml` in current directory

    ```yaml
    all:
        hosts:
            remote-machine:
                ansible_host: 192.168.1.123
                ansible_user: fjelloverflow
    ```

3. Copy ssh-key to server

    ```bash
    ssh-copy-id 192.168.1.123
    ```

3. Run playbook

    ```bash
    ansible-playbook playbook.yaml -K
    ```
