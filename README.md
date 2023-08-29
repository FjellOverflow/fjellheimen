# Homeserver

A docker-based setup and configuration of my home server.

<!-- TOC ignore:true -->
## Table of contents
<!-- TOC -->

- [Project structure](#project-structure)
- [Docker Compose files](#docker-compose-files)
- [Usage](#usage)
    - [Prerequisites](#prerequisites)
    - [Getting started](#getting-started)
    - [Services](#services)
        - [nginx-proxy-manager](#nginx-proxy-manager)
        - [homepage](#homepage)
        - [glances](#glances)
        - [portainer](#portainer)
        - [watchtower](#watchtower)
    - [Adding a new service](#adding-a-new-service)
- [Scripts & cronjobs](#scripts--cronjobs)
- [The host machine](#the-host-machine)
- [Diagrammatic setup](#diagrammatic-setup)
    - [Application stacks](#application-stacks)
    - [Container interactions](#container-interactions)
    - [Container in the network](#container-in-the-network)
    - [Request resolve](#request-resolve)
- [FAQ](#faq)
    - [Why is the environment folder empty except for general.env?](#why-is-the-environment-folder-empty-except-for-generalenv)
    - [Why is the data folder basically empty?](#why-is-the-data-folder-basically-empty)

<!-- /TOC -->
## Project structure
<details>

<summary>Click to show</summary>


- `compose` contains docker-compose files for various services.
- `data` contains the data for the services.
- `environment` contains `.env` files for the services.
- `.setup` contains the setup scripts for the host machine
- `.scripts` contains useful, related shell-scripts

A service ***myService*** is defined in its docker-compose file `compose/myservice.yml`:

```yml
version: '3'
services:
    myservice:
        image: my/service:latest
        volumes:
            - ./data/myservice:/data
        env_file:
            - ./environment/myservice.env
```

It usually has a directory `data/myservice` that is mapped as a docker volume and an environment file `environment/myservice.env` that is given into the container.

</details>

## Docker Compose files
<details>

<summary>Click to show</summary>

A full-fledged docker compose file can look like this:

```yml
version: '3'

name: homeserver

services:

    myservice:
        image: my/service:latest
        container_name: myservice
        volumes:
            - ./data/myservice/config:/config
            - /some/other/directory/media:/media
        networks:
            - proxy-network
        env_file:
            - ./environment/general.env
            - ./environment/myservice.env
        healthcheck:
            test: curl --fail http://localhost:8080 || exit 1
            interval: 1m
            start_period: 20s
            timeout: 10s
            retries: 3

networks:
    proxy-network:
        external: true
```
- `name: homeserver` is set as the services, even if defined in different docker compose files, should belong to the same stack. Depending on how, when and from where the container is first started, compose might assign them to different stacks. `name: homeserver` overrides that behaviour and assigns all services to the ***homeserver*** stack

- `container_name: myservice`: for a more independent service, the container name will be ***myservice***; for containers that belong or are intended to be run together, they will be named ***purpose-service1***, ***purpose-service2*** and so on.

- While some services do not make use of any volumes, many need at least one volume to store their data or configuration, which will be stored in `data/myservice/config` and hence the volume mapping `./data/myservice/config:/config`. Some might have additional volumes, for instance some media directory `/some/other/directory/media:/media`. The idea is that all data that is needed for the home server setup to run is stored in `data`, while other data, for instance a directory with media, does not strictly belong to the home server setup, but are an independent data source.

- Many, if not almost all, containers are explicitly set to belong to the externally defined ***proxy-network***. This is due to the reverse-proxy setup of the home server and is explained in detail in section TODO.

- Almost all containers receive environment variables via the `general.env` file. This sets, amongst others, the appropriate timezone **TZ** and **UID** and **GID** for containers to be run as the user (and not **root**), which is universal for most containers. Containers that need specific **ENV** variables set (such as passwords, API-keys, ...), get, in addition, the file `environment/myservice.env` as input.

- `healthcheck` is set up with most containers as well; it monitors that the container is well (that the application running inside the container is responding to requests). Thus containers will show `Up 2 hours (healthy)` as status.
</details>

## Usage

### Prerequisites
<details>
<summary>Click to show</summary>

For this setup to work, you need:

- Ports `80` and `443` forwarded on your router.
- A domain pointed to your **public IP adress**.
</details>

### Getting started
<details>

<summary>Click to show</summary>

- **Optional**:
    For the setup to work out of the box, the directory must be located at `\homeserver`.
    ```bash
    sudo cp -r homeserver /homeserver
    ```
    Feel free to skip this and adjust the filepaths throughout this project.

- **Optional**:
    Adjust `environment/general.env` to your UID/GID and timezone.

- Start essential ***server*** services.
    ```bash
    docker compose -f /homeserver/compose/server.yml up -d
    ```
    This should start, amongst others, ***nginx-proxy-manager***.

- You should now be able to access ***nginx-proxy-manager*** on [http://localhost:81](http://localhost:81). Create an account and login.

- There, you want to create a **SSL**-certificate for your subdomain(s) and point subdomains to the different services.
    - For ***nginx-proxy-manager*** itself, create a new proxy host and point the domain `proxy.yourdomain.com` to `http://your-local-ip:81` and enable the SSL-certificate. Now you should be able to access the ***nginx-proxy-manager*** at `proxy.yourdomain.com`.

    - Other services that are running on the ***proxy-network*** can be added similarly, by pointing `myservice.yourdomain.com` to `http://containername:portnumber`.

    - Services that are running in `network_mode: host` (or not in a container but natively on the host) can be added by using the servers ***local IP***, similarly to ***nginx-proxy-manager***.

- **Optional**:
    To use the convient dashboard, provided by ***homepage***, add the file `environment/homepage.env`. Take a look and adjust the configurations in `data/homepage/config`. There ***ENV*** variables, like `HOMEPAGE_VAR_NPM_URL`, are used. For them to resolve properly, add them in `environment/homepage.env` and rereate the ***server-homepage*** container. If you point the ***homepage*** container to an URL like `dashboard.yourdomain.com` you get a neat dashboard showing running services, docker stats and server metrics.

</details>

### Services
<details>
<summary>Click to show</summary>

A short summary of the **server**-services. Of course there is plenty of additional services, which are irrelevant to the homeserver infrastructure.

#### nginx-proxy-manager
The most central service. He exposes ports `80` (HTTP) and `443` (HTTPS) to the host network and is part of the ***proxy-network***. He takes all incoming requests and forwards them to the the right **IP** and **port**. Without it, the server infrastructure breaks.

We might for instance have ***myservice*** running on port **8080**. To secure the service, it is only on the ***proxy-network*** and thus not directly accessible from the host network.
By adding a proxy host in ***nginx-proxy-manager*** that forwards `https://myservice.yourdomain.com` to `http://myservice:8080`, we make the service accessible with HTTPS.

***nginx-proxy-manager*** hence acts as reverse proxy that seperates the host network from the applications running and securely hands incoming requests to the proper service.

See [nginx-proxy-manager.com](https://nginxproxymanager.com/).

#### homepage
A selfhosted dashboard. Out of the box it is configured to show all the running services, including more detailed information and CPU and memory usage and container health. It also shows server metrics, bookmarks and more. It is configured by editing the files in `data/homepage/config` and adding **ENV** variables to `environment/homepage.env`.

See [gethomepage.dev](https://gethomepage.dev/).

#### glances
Glances collects server metrics (CPU, memory, disk usage, ...) to be displayed on the server dashboard.

See [nicolargo/glances](https://github.com/nicolargo/glances).


#### portainer
Portainer is a web UI to manager docker.

See [portainer.io](https://www.portainer.io/).

#### watchtower
Automatically updates docker images.

See [containrrr.dev/watchtower/](https://containrrr.dev/watchtower/).

</details>

### Adding a new service
<details>
<summary>Click to show</summary>

To add a new service to the setup, you create a new docker compose file `compose/myservice.yml`.

- Add `name: homeserver` for the service to be part of the stack

- Add `container_name: myservice` to easily identify the container

- Make sure to add the container to the ***proxy-network*** by adding
    ```yml
    networks:
        proxy-network:
            external: true
    ```
    to the file and
    ```yml
    networks:
      - proxy-network
    ```
    to the service

- Add a custom healthcheck if wanted or needed

Lets say the service needs to persist data (a directory called `appdata`) and environment variables (`DB_USER` and `DB_PASSWORD`).

- Create the folder `data/myservice/appdata`
- Add the line `- ./data/myservice/appdata:/appdata` under `volumes` in `compose/myservice.yml`
- Create the file `environment/myservice.env`
- Add the lines `DB_USER=myuser` and `DB_PASSWORS=mysecretpass` to `environment/myservice.env`
- Add `- ./environment/myservice.env` under `env_file` in `compose/myservice.yml`


You can now run the container for the first time:

```bash
$ docker compose -f compose/myservice.yml up -d
```

Now that the container is running, we want to access it. Lets say, the server runs a web interface on port 8080.

- Log into **nginx-proxy-manager**
- Navigate to *Proxy Hosts* -> *Add Proxy Host*
- Under *Domain Names* enter *myservice.example.com*
- Under *Forward Hostname/IP* enter *myservice*
- Under *Forward Port* enter *8080*
- Under *SSL* add a SSL Certificate, if wanted

Now the new service should be up and running and accessible under *myservice.example.com*.
</details>

## Scripts & cronjobs
`.scripts` contains a collection of different useful scripts.
- `notify.sh` is used in most other scripts; it pushes a message on the notification service I have set up to receive push-notifications on my phone
- `backup.sh` creates a compressed backup of the entire homeserver directory
- `on_startup.sh` sends a notification that the server is up and running and a list of running containers
- `reboot.sh` reboots the server and informs about the containers running prior to shutting down
 `check_public_ip.sh` keeps tabs on the public ip and sends a notification when it changed

The scripts accomplish very mundane simple tasks and are not much use on their own; however I have set up my server to call them on a schedule with cronjobs, thus have added calls to them in `sudo crontab -e`.

They are, for instance, to check the public IP at midnight, to backup every saturday night, to restart every sunday and so on.

Note that for the scripts to work, a proper `.env` file must be in the directory.

## The host machine
<details>
<summary>Click to show</summary>
This homeserver setup is supposed to run on a Ubuntu Desktop machine.
It has been tested and tweaked for Ubuntu Desktop 22.04.3.
To simplify and speed up the process of setting up a host machine,
there is a setup script located in `.setup`.

- Install [Ubuntu Desktop](https://ubuntu.com/download/desktop)
    - **Optional**: Check "Log in automatically" on installation
- Install [Git](https://git-scm.com/download/linux)

At this point we are ready to clone this repository and execute the setup script. Note that, if you have not installed and enabled ssh-server yet, you will need to do this on the machine itself. Feel free to install ssh-server yourself, then ssh into the server machine from your own machine and run the script remotely.

The script will install some essentials and perform some useful and necesary tweaks, bringing the system into a state where its perfectly ready to run the homeserver. The script expects a `ubuntu.env` file next to it, containing **ENV** variables:

|VAR | Description
---|---
USERACCOUNT | name of the default user on machine
MEDIADRIVE_DIR | where the mediadrive should be mounted (e.g. /mediadrive)
MEDIADRIVE_ID | the device uid of the mediadrive
HOMESERVER_DIR | where the homeserver drive should be mounted (e.g. /homeserver)
HOMESERVER_ID | the device uid of the homeserver drive

The script is simply called with
```bash
./homeserver/.setup/ubuntu.sh
```
It will prompt with *[y/n]* before each task and, if succesfully completing it, will set the **ENV** variable ***RAN_TASK_[task-id]=true*** in `ubuntu.env` to avoid running it again the next time. Feel free to set or unset those variables yourself.

***WARNING:*** Make sure to check the script yourself before executing and make sure that **a)** you understand what it is doing and why and **b)** that is necesary and applicable in your use case/system.
Never blindly execute scripts from the web.

Other than that, for my personal setup, I like to:

- switch the default shell from bash to [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
- install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki)
- install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
- enable them by adding `plugins=(zsh-autosuggestions zsh-syntax-hightlighting)` to my `.zshrc`
- Add `[ -f /homeserver/.setup/.aliases ] && source /homeserver/.setup/.aliases` to my `.zshrc` to get my personal aliases
- Open the ports for nginx-proxy-manager and Plex in UFW with `sudo ufw allow port/tcp`

</details>

## Diagrammatic setup

### Application stacks
<details>
<summary>Click to show</summary>

![Application stacks](/.diagrams/stack.png)
</details>

### Container interactions
<details>
<summary>Click to show</summary>

![Container interactions](/.diagrams/docker.png)
</details>

### Container in the network
<details>
<summary>Click to show</summary>

![Container in network](/.diagrams/network.png)
</details>

### Request resolve
<details>
<summary>Click to show</summary>

![Network request resolves](/.diagrams/resolve.png)
</details>

## FAQ

### Why is the `environment` folder empty (except for `general.env`)?
<details>
<summary>Click to show</summary>

Locally, this folder is not empy, but contains the `ENV` variables for the various services. That means usernames, passwords, urls, API-keys and more. So it needs to be adjusted per-case basis, is private and does not belong into a git repository.
</details>

### Why is the `data` folder (basically) empty?
<details>

<summary>Click to show</summary>

It is not empy, but contains the empty skeleton of my local directory structure. All of the directories `data/myservice` are mapped as docker volumes to some containers, which means they need to exists, for the container to run. They are (mostly) empty, as they contain the data of the running services, which does not belong (and does not fit) into a git repository.

(An exception is `data/homepage`), as it contains the (not private) configuration for the home server dashboard.
</details>


