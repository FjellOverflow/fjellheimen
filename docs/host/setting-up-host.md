# Setting up the host

While most services on the home server will run [containerized](/stacks/overview), some bare-metal installations must be performed on the host machine to set things up.

::: warning For non-debian users
Many steps outlined here are specific to Debian. If you are setting up the home server on another host OS, some steps might need to be adjusted or substituted with appropriate alternatives. Use provided commands with caution.
:::

## Preseeding Debian 12

As the server is meant to run on Debian 12, the OS should be freshly installed. To accelerate the installation, a [preeseding](https://www.debian.org/releases/stable/amd64/apbs01.en.html) file is available at `setup/debian12_preseed.cfg`. It defines answers to the choices to be made when doing a manual install, hence when using preseeding the installer will skip these questions, minimizing user intervention.

The file can be used by, after launching the installer, navigating to *Advanced Options* -> *Automated Install* and entering the URL of some preseeding file. In its current form, it does not define answers for the following points, meaning the user must manually configure during installation:

- Disk partitioning
- User password
- bootloader location

When using preseeding, make sure to adjust the choices in the file to your needs.
Of cource, the system can always be installed entirely manually or any other preferred way, without using preseeding.

## Bare minimum

The minimal working server installation needs at least a user with [sudo](https://wiki.debian.org/sudo) privileges as well as [Docker](https://docs.docker.com/engine/install/debian/) installed.

## Ansible

To get started with a rich suite of packages and get some common configurations done automatically, an [Ansible](https://www.ansible.com/) playbook is provided in the `setup` directory. For detailed instructions refer to `setup/README.md`, but roughly sketched, the playbook will

- set hostname and enable passwordless sudo
- disable ssh-password auth
- install and configure [Uncomplicated Firewall](https://en.wikipedia.org/wiki/Uncomplicated_Firewall)
- install [Docker](https://www.docker.com/)
- install [Samba](https://www.samba.org/) and create user
- configure [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) as default shell with [useful plugins](https://github.com/ohmyzsh/ohmyzsh)
- install additional packages

It assumes ssh access to the machine and can be run with `ansible-playbook -K playbook.yaml` from within the `setup` directory.
When using the playbook, make sure to check the tasks being run and adjust them to your needs. Of course all tasks can be easily done manually by hand, without using Ansible.

## Laptop as host machine

When using a laptop as a host machine, a few tweaks can be useful.

### Additional packages

Debian includes packages targeted for laptop hosts, but they might not be present, for example when [preseeding](#preseeding-debian-12). They can be added manually.

```bash
sudo tasksel install laptop
```

### Disable WIFI

When the machine is connected with Ethernet, we can disable WiFi. Assuming the WiFi interface is `wlan0`, the following command comments out the relevant lines in the network configuration.

```bash
sudo sed -i '/wlan0/ s/^/#/' /etc/network/interfaces
```

### Disable Bluetooth

The same applies to Bluetooth.

```bash
sudo systemctl disable bluetooth
```

### Display timeout

When the machine runs no graphical environment, the display might be always on, consuming unnecessary power. We can add a timeout to the kernel parameters.

```bash
# edit GRUB configuration
sudo nano /etc/default/grub

# append parameter to this line and save
GRUB_CMDLINE_LINUX="... consoleblank=<SECONDS>"

sudo update-grub
sudo reboot
```
