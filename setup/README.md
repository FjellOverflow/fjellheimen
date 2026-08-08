# Setting up host

The homeserver is intended to run on Fedora. Installing a fresh Fedora Server Edition is precondition to applying this setup.

> [!TIP]
> [nisse](https://github.com/FjellOverflow/nisse) applies an opinionated, batteries-included base to a fresh Fedora install. Running it beforehand can be useful, but is not a requirement.

1. Install Ansible and git on the server

    ```bash
    sudo dnf install -y ansible git
    ```

2. Clone the repository

    ```bash
    git clone https://github.com/FjellOverflow/fjellheimen.git ~/fjellheimen
    ```

3. Install collections and run playbook

    ```bash
    cd ~/fjellheimen/setup
    ansible-galaxy collection install -r requirements.yaml
    ansible-playbook site.yaml -K
    ```