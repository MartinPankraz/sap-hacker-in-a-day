# Unguided experience

[ < Quest 1](quest1.md) - **[🏠Home](../README.md)**

In case you are not part of a guided workshop, you will find the preliminary steps to setup the lab yourself below.

* Verify if a git client is present by running `git version` on your terminal.

If not, [install](https://git-scm.com/downloads) as per your environment and clone this repos.

```bash
git clone https://github.com/MartinPankraz/sap-hacker-in-a-day.git
```

> [!TIP]
> If you are new to GitHub, you can alternatively also download the zip file from the [main page](https://github.com/MartinPankraz/sap-hacker-in-a-day/archive/refs/heads/main.zip) and extract it to your desired location.

* For the provided convenience scripts used in the next section, install [PowerShell 7.4+](https://learn.microsoft.com/powershell/scripting/overview). It runs on any OS.

## Step 0: Spin up your hosting environment

A common practice for "playing" with hacking tools is to utilize an *isolated environment* instead of your "bare" machine. This can be a container or a virtual machine. This way, you can *keep your main machine clean* and avoid any unintended consequences. Below are a couple of suggestions.

We **recommend using a containerized environment** for a code based approach that results in easy reproducibility. Choose from below options. Narrative here leads with Step 1a.

* [Step 1a](#step-1a-build-image-from-dockerfile-and-run-container-on-your-local-machine) - Use container runtime like Docker/Podman on your local machine or
* [Step 1b](quest1b.md) - Use a virtual machine with a hypervisor like VirtualBox or Hyper-V on your local machine or cloud-based virtual machine like Azure VMs.

## Step 1a: Build image from Dockerfile and Run container on your local machine

* Follow install instructions for Docker/Podman and cross-platform PowerShell [here](../docker-kali/README.md).
* Docker/Podman rely on WSL on Windows. [Install from here](https://learn.microsoft.com/windows/wsl/install#prerequisites).
* Run below commands in your terminal from the git repos in sequence to build the image and run the container.

> [!TIP]
> In case powershell fails with a message like "cannot be loaded because the execution of scripts is disabled on this system", consider running the command `set-executionpolicy remotesigned` to allow script execution. If not you may also run the commands contained in the scripts manually.

### For Docker (with provided PowerShell scripts)

```bash
cd .\docker-kali\
.\build-image.ps1
.\run-container.ps1
```

> [!TIP]
> The scripts are meant for initial execution. When revisiting the container after a break or similar, run the following from within the container to reach operational status again:
>
> ```bash
> docker start -ia my-evilginx-container
> ```
>
> This command takes you directly to the Evilginx command line interface.

### For Podman (with plain bash commands)

```bash
podman machine init
podman machine set --rootful
podman machine start
cd ./docker-kali/
podman build -t my-evilginx-kali:latest .
podman run -it -p 443:443 --name my-evilginx-container my-evilginx-kali:latest
```

> [!TIP]
> The scripts are meant for initial execution. When revisiting the container after a break or similar, run the following from within the container to reach operational status again:
>
> ```bash
> docker start -ia my-evilginx-container
> ```
>
> or
>
> ```bash
> podman start -ia my-evilginx-container
> ```
>
> This command takes you directly to the Evilginx command line interface.

> [!IMPORTANT]
> When restarting the config process, you will need to download the required certificate, and repeat config steps again. Run the command `.\get-crt.ps1` from the git repos in another terminal outside of the EvilGinx process.

This will create the `my-evilginx-container` with fixed names for static referencing for downstream commands.

## Where to next?

Continue with the [next section](quest1.md#step-2-configure-evilginx3) to configure Evilginx3.

[ < Quest 1](quest1.md) - **[🏠Home](../README.md)**

[🔝](#)
