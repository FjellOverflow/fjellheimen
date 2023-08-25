#!/usr/bin/env bash

function no_env() {
    echo File ubuntu.env must be located in the current directory.
    exit 1
}

echo "Setup script for homeserver. Intended and tested for Ubuntu 22.04.3 Desktop."

source ubuntu.env || no_env

function prompt_user() {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;  
            [Nn]*) return 1 ;;
        esac
    done
}

function setup_ssh() {
    sudo apt install -y openssh-server &&
    sudo systemctl enable ssh
}

function passwordless_sudo() {
    # https://linuxize.com/post/how-to-run-sudo-command-without-password/
    sudo touch /etc/sudoers.d/$USERACCOUNT &&
    echo "$USERACCOUNT  ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USERACCOUNT
}

# unchecked
function setup_ufw() {
    sudo ufw allow samba &&
    sudo ufw allow ssh &&
    sudo ufw enable
}

# unchecked
function disable_ssh_psswd_auth() {
    prompt_user "You will not be able to login with password after that.
Make sure you have copied your ssh-key with ssh-copy-id onto the machine before proceeding.
Continue?" || return 1

    # https://stackoverflow.com/questions/20898384/disable-password-authentication-for-ssh
    sudo sed -i -E 's/#?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config &&
    sudo systemctl restart sshd
}

# unchecked
function setup_zsh() {
    # https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
    sudo apt install -y zsh && 
    chsh -s $(which zsh) &&

    # https://github.com/ohmyzsh/ohmyzsh/wiki
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&

    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&

    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&

    sed -i -E 's/#?plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc &&
    echo "[ -f /homeserver/setup/.aliases ] && source /homeserver/setup/.aliases" >> ~/.zshrc
}

# unchecked
function automatic_login() {
    sudo sed -i -E 's/#? AutomaticLoginEnable = true/AutomaticLoginEnable = true/' /etc/gdm3/custom.conf &&
    sudo sed -i -E s/#? AutomaticLogin = user1/AutomaticLogin = $USERACCOUNT/ /etc/gdm3/custom.conf
}

# unchecked
function setup_samba() {
    sudo apt install -y samba
    sudo echo "
[mediadrive]
comment = mediadrive
path = /mediadrive
read only = yes
browsable = yes
guest ok = yes
write list = $USERACCOUNT

[homeserver]
comment = homeserver
path = /homeserver
read only = yes
browsable = yes
write list = $USERACCOUNT" >> /etc/samba/smb.conf
    sudo systemctl restart smbd
}

# unchecked
function hdd_mountpoints() {
    sudo echo /dev/disk/by-id/$MEDIADRIVE-0:0 /mediadrive auto nosuid,nodev,nofail,x-gvfs-show 0 0 >> /etc/fstab &&
    sudo echo /dev/disk/by-id/$HOMESERVER-0:0 /homeserver auto nosuid,nodev,nofail,x-gvfs-show 0 0 >> /etc/fstab
}

prompt_user "Enable sudo without password?" && passwordless_sudo || echo "Skipping..."

prompt_user "Install ssh?" && setup_ssh || echo "Skipping..."

prompt_user "Install zsh as default shell (incl. oh-my-zsh, hightlighting, aliases)?" && setup_zsh|| echo "Skipping..."

prompt_user "Disable ssh password authentication?" && disable_ssh_psswd_auth || echo "Skipping..."

prompt_user "Set static mount points for mediadrive and homeserver?" && hdd_mountpoints || echo "Skipping..."

prompt_user "Enable /mediadrive and /homeserver samba shares?" && setup_samba || echo "Skipping..."

prompt_user "Enable ufw and allow ssh and samba?" && setup_ufw || echo "Skipping..."

prompt_user "Enable automatic login?" && automatic_login || echo "Skipping..."