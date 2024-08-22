# Docker instructions for Kali Linux

Kali Linux is an Advanced Linux distribution used for Penetration Testing, Ethical Hacking and network security assessments.

For your convenience cross-platform PowerShell scripts have been provided. [PowerShell 7.4+](https://learn.microsoft.com/powershell/scripting/overview) runs on any OS.

Only prerequisite is [Docker Desktop for your OS](https://docs.docker.com/desktop/install/windows-install/).

* [Install Docker](https://docs.docker.com/desktop/install/windows-install/)
* Continue your setup [here](../student/quest1.md#step-2-configure-evilginx3).

## Podman as alternative to Docker

* [Install Podman](https://podman.io/)

* Run below commands in sequence to pre-configure podman.

```bash
podman machine init
podman machine set --rootful
podman machine start
```

* Continue your setup [here](../student/quest1.md#step-1a-build-image-from-dockerfile-and-run-container-on-your-local-machine).
