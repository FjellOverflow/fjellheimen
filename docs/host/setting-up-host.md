# Setting up the host
While most services on the home server will run [containerized](/stacks/overview), some bare-metal installations must be performed on the host machine to set things up.

::: warning For non-debian users
Manysteps outlined here are specific to Debian. If you are setting up the home server on another host OS, some steps might need to be adjusted or substituted with appropriate alternatives. Use provided commands with caution.
:::

## Essentials
These are the things needed on the host machine to run the documented home server setup.

### Install sudo
```bash
su --login
apt install -y sudo
adduser $USERNAME sudo
```
Remember to log out and log in again to apply changes.


### Install Docker
Follow the [official documentation](https://docs.docker.com/engine/install/debian/) to install Docker.

## Security
Some bare minimum security tweaks.

### Install Uncomplicated Firewall
It is important to allow `ssh` to not lose remote connection. Traffic on any other ports must also be manually enabled when needed.
```bash
sudo apt install -y ufw
sudo ufw allow ssh
sudo ufw enable
```

### SSH Key-based authentication
Ensure the SSH key is copied from the device to the server before disabling password authentication.
```bash
# on the workstation
ssh-copy-id $USERNAME@$SERVER_IP
```
Disable password authentication on the server.

```bash
sudo sed -i -E 's/#?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config &&
sudo systemctl restart sshd
```

## Useful
Here are some non-essential but useful tweaks:

### Passwordless sudo
Save time by not typing out a password when using `sudo`.
```bash
sudo touch /etc/sudoers.d/$USERNAME &&
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USERNAME
```

### Git
```bash
sudo apt install -y git
```
### Share a folder with Samba
Install `samba`.
```bash
sudo apt install -y samba
sudo service smbd restart
sudo ufw allow samba
```

Share a folder.
```bash
# add this in /etc/samba/smb.conf
[media]
    comment = Media
    path = /home/user/media
    browsable = yes
    write list = $USERNAME
    
# restart
sudo service smbd restart
sudo smbpasswd -a $USERNAME
# assign a new password
```

## Laptop as host machine
When using a laptop as a host machine, a few tweaks can be useful.

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