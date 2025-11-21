# Getting started

This documentation focuses on getting up and running and managing a Linux-based home server based on Linux, mainly with [Docker](https://docs.docker.com/get-docker/). While mostly containerized, the setup is ideally run on a dedicated machine with full shell access.

The configuration files live in the [FjellOverflow/fjellheimen](https://github.com/FjellOverflow/fjellheimen) repository and define infrastructure & setup for mostly [media management and consumption](/stacks/servarr) and [server administration](/stacks/core).

## Goal

The docs mean to document and explain the infrastructure and core concepts behind the setup. With configuration files and documentation at hand, the whole server setup should be quick to setup, highly reproducible, and easy to migrate or recover. As a personal project, most choiced are obviously opinionated and reflect my own use cases and preferences (sensitive data is omitted with `.gitignore`).

## Target audience

Me. Because intended for personal use, these docs are a guide for my future self to help with adjustments, troubleshooting, or migrations of the server. Still, it could also inspire or aid interested others in setting up their own home servers. 

Naturally, the docs assume certain familiarity with Linux, command-line usage, Docker, and basic networking. Visit the [Resources](/introduction/resources) page for additional hints.

::: warning A note on security
Good security measures are critical for protecting your personal data and devices; measures such as [VPNs](https://en.wikipedia.org/wiki/Virtual_private_network), [reverse proxies](https://en.wikipedia.org/wiki/Reverse_proxy), and [firewalls](https://en.wikipedia.org/wiki/Firewall_(computing)) are recommended. Avoid exposing services directly to the internet and isolate networks for enhanced security. This documentation is not the place to seek guidance on such things; if in doubt, please consult qualified experts based on your use cases.
:::