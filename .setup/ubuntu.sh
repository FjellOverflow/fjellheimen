#!/usr/bin/env bash

TASK_NUMBER=8

CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ENV_FILE=$CURRENT_DIR/ubuntu.env

function no_env() {
    echo Aborting due to missing ubuntu.env.
    exit 1
}

source $ENV_FILE || no_env

echo "Setup script for homeserver. Intended and tested for Ubuntu 22.04.3 Desktop.

USERACCOUNT=$USERACCOUNT
MEDIADRIVE_ID=$MEDIADRIVE_ID, MEDIADRIVE_DIR=$MEDIADRIVE_DIR
HOMESERVER_ID=$HOMESERVER_ID, HOMESERVER_DIR=$HOMESERVER_DIR
"

OPEN_TASKS=()
for ((i=0;i<=$TASK_NUMBER;i++)); do
    RAN_TASK_VAR="RAN_TASK_$i"
    RAN_TASK="${!RAN_TASK_VAR}"
    
    if [ "$RAN_TASK" != true ]; then
        OPEN_TASKS+=($i)
    fi
done

echo "Tasks to run: [${OPEN_TASKS[@]}]
"

function prompt_user() {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;  
            [Nn]*) return 1 ;;
        esac
    done
}

TASK_PROMPT_0="Enable 'sudo' without password?"
function TASK_0() {
    # https://linuxize.com/post/how-to-run-sudo-command-without-password/
    sudo touch /etc/sudoers.d/$USERACCOUNT &&
    echo "$USERACCOUNT ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USERACCOUNT
}

TASK_PROMPT_1="Install and enable ssh server?"
function TASK_1() {
    # https://ubuntu.com/server/docs/service-openssh
    sudo apt install -y openssh-server &&
    sudo systemctl try-reload-or-restart ssh
}

TASK_PROMPT_2="Install and enable samba?"
function TASK_2() {
    # https://ubuntu.com/tutorials/install-and-configure-samba#3-setting-up-samba
    sudo apt install -y samba &&
    sudo service smbd restart
}

TASK_PROMPT_3="Enable UFW and allow ssh and samba?"
function TASK_3() {
    sudo ufw allow samba &&
    sudo ufw allow ssh &&
    sudo ufw enable
}

TASK_PROMPT_4="Install git?"
function TASK_4() {
    sudo apt install -y git
}

TASK_PROMPT_5="Install docker and docker compose?"
function TASK_5() {
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo docker run hello-world
}

TASK_PROMPT_6="Share $MEDIADRIVE_DIR and $HOMESERVER_DIR with samba?"
function TASK_6() {
    echo "
[mediadrive]
comment = mediadrive
path = $MEDIADRIVE_DIR
read only = yes
browsable = yes
guest ok = yes
write list = $USERACCOUNT

[homeserver]
comment = homeserver
path = $HOMESERVER_DIR
read only = yes
browsable = yes
write list = $USERACCOUNT" | sudo tee -a /etc/samba/smb.conf &&
    sudo service smbd restart
}

TASK_PROMPT_7="Disable ssh password authentication?"
function TASK_7() {
    prompt_user "You will not be able to login with password after that.
Make sure you have copied your ssh-key with ssh-copy-id onto the machine before proceeding.
Continue?" || return 1

    # https://stackoverflow.com/questions/20898384/disable-password-authentication-for-ssh
    sudo sed -i -E 's/#?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config &&
    sudo systemctl restart sshd
}

TASK_PROMPT_8="Set static mount points $MEDIADRIVE_DIR and $HOMESERVER_DIR?"
function TASK_8() {
    echo /dev/disk/by-id/$MEDIADRIVE_ID-0:0 $MEDIADRIVE_DIR auto nosuid,nodev,nofail,x-gvfs-show 0 0 | sudo tee -a /etc/fstab &&
    echo /dev/disk/by-id/$HOMESERVER_ID-0:0 $HOMESERVER_DIR auto nosuid,nodev,nofail,x-gvfs-show 0 0 | sudo tee -a /etc/fstab
}

for ((i=0;i<=$TASK_NUMBER;i++)); do
    RAN_TASK_VAR="RAN_TASK_$i"
    RAN_TASK="${!RAN_TASK_VAR}"
    
    if [ "$RAN_TASK" = true ]; then
        continue
    fi

    TASK_PROMPT_VAR="TASK_PROMPT_$i"
    TASK_PROMPT="${!TASK_PROMPT_VAR}"

    prompt_user $TASK_PROMPT &&
    TASK_$i &&
    echo RAN_TASK_$i=true >> $ENV_FILE
done