# Quest 1 - Buckle up!

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

In this tutorial, you will perform basic deployments to set up your environment for the hands-on lab. You will also learn how to install a phishing simulation tool called [EvilGinx](https://help.evilginx.com/docs/intro) to prepare for the next quest.

## Installation for hands-on lab

Verify if a git client is present by running `git version` on your terminal.

If not, [install](https://git-scm.com/downloads) as per your environment and clone this repos.

```bash
git clone https://github.com/MartinPankraz/sap-hacker-in-a-day.git
```

### Step 0: Consider using a container or virtual sandbox to keep your machine "clean"

A common practice for "playing" with hacking tools is to utilize an *isolated environment*. This can be a virtual machine or a container. This way, you can *keep your main machine clean* and avoid any unintended consequences. Below are a couple of suggestions.

We recommend using a containerized environment for a code based approach that results in easy reproducibility.

See instructions for Docker and cross-platform PowerShell [here](../docker-kali/README.md).

> [!NOTE]
> Alternatives are:
> * Local virtual machines (embedded in your physical device)
>    * [Hyper-V on Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) or
>    * [VirtualBox](https://www.virtualbox.org/) or similar.
> * Remote virtual machines (Hyperscaler options)
>    * Spin up environments with [Azure VMs](https://azure.microsoft.com/free/) with free credits or
>    * Any other available to you.

### Step 1: Build image from Dockerfile and Run container

```bash
cd ..\docker-kali\
.\build-image.ps1
.\run-container.ps1
```

This will create the `my-evilginx-container` with fixed names for static referencing for downstream commands.

Once Evilginx shows up on your console as its own process, continue your setup...

### Step 2: Configure Evilginx3

See the official documentation for reference [here](https://help.evilginx.com/docs/intro).

```bash
config ipv4 127.0.0.1
config domain dsag-red-team.com
```

<p align="center" width="100%">
<img alt="Configure evilginx3" src="assets/quest1/config-evilginx3.png"  width="600">
</p>

> [!NOTE]
> hackers use elusive domains like 'microsofttonline.com' to trick users. Outlook and M365 pick up such attempts, but other email clients may not. Be aware we use a domain that is not registered and only used for this tutorial.

#### Certificate handling

* Get the required root certificate from EvilGinx using the command from your terminal outside of the EvilGinx process. This will copy the generated ca.crt file from the container to your hosting OS into the [docker-kali folder](../docker-kali/).

```bash
.\get-crt.ps1
```

* Add this certificate to the Trusted Root Certificate Authorities store of the Current User (double click the file -> Install Certificate). Otherwise, you will get a certificate error when accessing the phishing page!

In some cases, you may need to restart your machine for the certificate changes to take effect.

### Step 3: Create or retrieve a phishlet for your scenario

We will use a sample phishlet for M365 shared by [Jan Bakker](https://github.com/BakkerJan/evilginx3/blob/main/microsoft365.yaml).

> [!NOTE]
> [The phishlet](../docker-kali/microsoft365.yaml) has already been copied into the container and made available to EvilGinx through folder `/usr/share/evilginx2/phishlets`.

* Verify the M365 phishlet is loaded as expected.

<p align="center" width="100%">
<img alt="new phishlet" src="assets/quest1/new-phishlet.png"  width="600">
</p>

> [!TIP]
> Always check for updates on the phishlets and the EvilGinx tool itself. Things are changing rapidly in the security world!

### Step 4: Prepare your phishing lure

```bash
phishlets hostname microsoft365 dsag-red-team.com
phishlets enable microsoft365 
```

<p align="center" width="100%">
<img alt="prepare phishing lure" src="assets/quest1/prepare-phsishing-lure.png"  width="600">
</p>

#### Enhance your hosts file for local testing

```bash
phishlets get-hosts microsoft365
```

> [!TIP]
> You may ignore the redundant third line of the output.

<p align="center" width="100%">
<img alt="get-hosts" src="assets/quest1/phshlet-gethost.png"  width="600">
</p>

* Add the output to your hosts file located at `C:\Windows\System32\drivers\etc\hosts`.

> [!IMPORTANT]
> You will need admin rights to edit this file. You may need to execute your editor with elevated rights (Run as Administrator).

<p align="center" width="100%">
<img alt="hosts" src="assets/quest1/hosts.png"  width="600">
</p>

#### Create your phishing lure

```bash
lures create microsoft365
lures get-url 0
```

<p align="center" width="100%">
<img alt="creat fishing lure" src="assets/quest1/create-phishing-lure.png"  width="600">
</p>

* Open the generated URL (https://login.dsag-red-team.com/some-key) in your browser to see the phishing page.

* Check the Evilginx3 console for the captured output so far ("new visitor has arrived" etc.).

<p align="center" width="100%">
<img alt="new visitor" src="assets/quest1/new-visitor.png"  width="600">
</p>

## Where to next?

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

[🔝](#)
