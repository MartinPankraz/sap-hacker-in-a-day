# Step 1b: Alternative setup

In case corporate policies or any other reason prevent your from installing the required tools on your local machine, you can use:

* Local virtual machines (embedded in your physical device)
    * [Hyper-V on Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) or
    * [VirtualBox](https://www.virtualbox.org/) or similar.
 * Remote virtual machines (Hyperscaler options)
    * Spin up environments with [Azure VMs](https://azure.microsoft.com/free/) with free credits or
    * Any other available to you.

During the guided lab experience we may have pre-configured environments available for you to use. If not, you can follow the steps below to set up your own environment.

Our guidance here refers to a windows environment on an Azure VM. You can adjust the steps to your environment.

## Step 0: Manual installation prerequisites

- Install [Git](https://git-scm.com/downloads) on your machine

> [!TIP]
> If you have not installed a Git client, you can also go directly to the [Evilginx3 repo](https://github.com/kgretzky/evilginx2), click on *Code* and *Download ZIP*. Once the ZIP file is downloaded extract it to your virtual machine. 

> [!IMPORTANT]
> Many of you will run into Defender detections with the executable upon [download](https://github.com/kgretzky/evilginx2/releases). Consider [building the tool from source](#build-from-source) in such cases.

## Step 1: Install Evilginx3

```bash
git clone https://github.com/kgretzky/evilginx2.git
```

### Step 1a: Build from source

- Install [golang](https://go.dev/doc/install)
- Restart your terminal and verify the installation with `go version` command.

```bash
cd evilginx2
.\build_run.bat
```

- Allow Access on subsequent Defender firewall prompt like a vigilante in the making.

### Step 1b: Install the pre-built version if 1a does not work

In case you are lucky you can follow the normal install steps:

- Get the latest release from the [releases page](https://github.com/kgretzky/evilginx2/releases) (Assets -> evilginx*-64bit.zip) and follow the [quick start guide](https://help.evilginx.com/docs/getting-started/deployment/local).

- Allow Access on subsequent Defender firewall prompt like a vigilante in the making.

## Step 2: go back to the lead [Quest](quest1a.md#step-2-configure-evilginx3) and continue with Step 2 normally

## Where to next?

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

[🔝](#)