# Setting up host

The homeserver is intended to run on Debian. Setting up a new machine involves installing Debian 12 and configuring the server, which can be done with [Preseeding](https://www.debian.org/releases/stable/armhf/apbs04.en.html) and [Ansible](https://www.ansible.com/), respectively.

## Automated Debian install

The installation of Debian can be (mostly) automated. Obtain the official Debian 12 ISO and boot the machine. After starting the Debian installer, select *Advanced Options* -> *Automated Install* and in the following prompt enter the URL for the preseeding file, eg. `https://raw.githubusercontent.com/FjellOverflow/fjellheimen/main/setup/debian12_preseed.cfg`. The installer will then automatically proceed with the install, adhering to the choices preseeded. This particular preseed file leaves open setting the user password, partitioning and bootloader location. The installer will pause at these points and wait for the user to take the choices manually. When done the installer will finish and reboot the machine.

## Ansible

Much of the initial server configuration (immediately after installing a fresh debian) can be automated with Ansible.

### Terminology

*Workstation* refers to the computer that is currently in use, onto which this repository should be cloned and opened and that has ssh access to the machine we are going to set up.

*Server* refers to some (remote) machine that has a (fresh) Debian 12 installed on it, to which we will connect with ssh and which will be set up for use as a homeserver.

### Prerequisites

#### 1. Install Ansible on workstation

[See docs](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

#### 2. Create file `hosts` in current directory

```cfg
myhost ansible_host=192.168.1.123 ansible_user=johndoe
```

#### 3. Copy workstations ssh-key to server

```bash
ssh-copy-id 192.168.1.123
```

### Running playbook

Upon running the playbook, it will prompt for certain user input, such as `username` or `samba_password`, some of which have a default value set. Most likely the playbook needs to be run with `-K` to prompt for the servers `sudo` password, if passwordless `sudo` is not yet enabled.

```bash
ansible-playbook -K playbook.yaml
> Enter hostname [fjellheimen]: myhost
> Enter username [fjelloverflow]: johndoe
> Enter samba password:
```

The playbook is intended to be idempotent, hence can be run multiple times while only making the necessary changes to the system.

### Playbook overview

It is assumed the user Ansible connects to is the same as `username` and all configuration will be done for that exact user.

Roughly sketched, the playbook will

- set hostname and enable passwordless sudo
- disable ssh-password auth
- install and configure [Uncomplicated Firewall](https://en.wikipedia.org/wiki/Uncomplicated_Firewall)
- install [Docker](https://www.docker.com/)
- install [Samba](https://www.samba.org/) and create user
- configure [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) as default shell with [useful plugins](https://github.com/ohmyzsh/ohmyzsh)
- install additional packages
