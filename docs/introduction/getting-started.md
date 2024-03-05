# Getting started
This documentation focuses on setting up and managing a private home server based on Linux, primarily utilizing Docker.

## Contents
The setup includes configuration files and explanations for a Linux-based home server, running on a dedicated machine with full shell access, tailored for media management, consumption, and easy server administration, even remotely. The user base can vary from individual to multiple users, depending on machine specifications.

## Scope and purpose
This documentation accompanies [FjellOverflow/homeserver](https://github.com/FjellOverflow/homeserver) shedding light on the infrastructure and core concepts behind the setup. Tracking and documenting home server configuration files facilitate reproducibility, adoption, or migration to new machines. The focus is on the general server infrastructure and application integration, with personal preference-dependent application configurations omitted.

## Target audience
Me. Primarily intended for personal use, this documentation serves as a guide for future adjustments, troubleshooting, or migrations of the server. It may also assist others in setting up their own home servers, assuming familiarity with Linux, command-line usage, Docker, and basic networking. Visit the [Resources](/introduction/resources) page for additional background information and guidance on these topics.

::: warning Networking & security
If networking or implementing strict security measures is not of interest, consider using pre-made home server solutions or providers to avoid risking data loss or security breaches. This setup requires knowledge of networking concepts, including VPNs, reverse proxies, and firewalls.
:::

## Networking
While networking is essential for home servers, this documentation does not delve into it extensively, as it varies based on server type (VPS or physical machine), home network configuration and ISP. Seek guidance from qualified sources for specific networking setups.

## Security
Critical for protecting personal data and devices, security measures such as VPNs, reverse proxies, and firewalls are recommended. Avoid exposing services directly to the internet and utilize isolated networks for enhanced security. Again, for detailed security guidance, consult qualified experts based on individual use cases.