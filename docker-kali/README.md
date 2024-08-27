# Docker instructions for Kali Linux

Kali Linux is an Advanced Linux distribution used for Penetration Testing, Ethical Hacking and network security assessments.

* Install [PowerShell 7.4+](https://learn.microsoft.com/powershell/scripting/overview). It runs on any OS.
* [Install Docker](https://docs.docker.com/desktop/install/windows-install/) for your OS.
* Continue your setup [here](../student/quest1.md#step-1a-build-image-from-dockerfile-and-run-container-on-your-local-machine) and run the commands or scripts depending on your chosen container runtime.

## Podman as alternative to Docker

* [Install Podman](https://podman.io/)

* Run below commands in sequence to pre-configure podman.

```bash
podman machine init
podman machine set --rootful
podman machine start
```

* Continue your setup [here](../student/quest1.md#step-1a-build-image-from-dockerfile-and-run-container-on-your-local-machine) and run the commands or scripts depending on your chosen container runtime.
