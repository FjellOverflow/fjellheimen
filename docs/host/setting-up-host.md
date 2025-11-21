# Setting up the host

A general philosophical question is often whether to run applications directly on the machine ("bare-metal") or containerized. While both options have their good use-cases, this setup will almost exclusively rely on containetized apps; this means that things to set up and install on the host-machine are mostly general-purpose utilities.

## Bare minimum

A minimal working server installation needs at least a user with [sudo](https://wiki.debian.org/sudo) privileges as well as [Docker](https://docs.docker.com/engine/install/debian/) installed.

## Ansible

The full suite of packages and configurations for this setup are defined via Infrastructure-as-Code in form of [Ansible](https://www.ansible.com/) playbooks.

For more detailed information on the usage, refer to the `setup` directory and its own `README`. 

In a nutshell, the provided playbook first runs some roles from [ansible-fedora-setup](https://github.com/FjellOverflow/ansible-fedora-setup), then some additional tasks.

Defined are, among others, tasks that:

- installs [docker](https://docs.docker.com/), [dockcheck](https://github.com/mag37/dockcheck), [borg](https://www.borgbackup.org/), [tailscale](https://github.com/tailscale/tailscale)
- sets up firewall and cronjobs
- enables passwordless sudo
- disables ssh-password auth
- sets up [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) shell
- installs suite of other small utilities

The playbook is tailored to Fedora, but it can certainly be adapted to other distros; another option is using the playbooks as reference and setting the machine up by hand.