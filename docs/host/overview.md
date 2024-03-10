# Host

The *host* or *host machine* is the physical or virtual base for the home server. Most applications are intended to run [containerized](/stacks/overview) with [Docker](https://docs.docker.com/), but there are constraints to consider regarding the machine or operating system for the setup.

## Overview
To establish a functional home server, start by selecting and installing a suitable [Operating System](#operating-system).

After setting up the base system, proceed with additional package installations and configurations outlined in [Setting up host](/host/setting-up-host) to secure and optimize the server for web application hosting.

Familiarize yourself with [Shell aliases](/host/shell-aliases) for efficient command line interaction once the setup is complete.

Lastly, enable [Maintenance](/host/maintenance) tasks such as regular backups and updates to ensure smooth operation over time.

## Operating system

### Distribution selection
The setup is tailored for Linux. Factors like stability, security, ease of use, and documentation are crucial. Opting for [Debian](https://en.wikipedia.org/wiki/Debian), renowned for reliability in server environments, is recommended.

### OS installation
During [distribution installation](https://debian-handbook.info/browse/stable/sect.installation-steps.html), you can preselect included software. Since a server setup is commonly display-less, omitting personal use software conserves resources. In Debian installation, at the `Software selection` stage, uncheck `Desktop environments` to skip installation of a graphical environment. For remote access, choose `SSH server`. Selecting `Standard system utilities` adds essential command line tools.