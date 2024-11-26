# Mentor Guide

Run provided scripts to quickly build the student environment.

## Create Student VMs

The shell script using [create_student_vms.sh](./env-prep/create_student_vms.sh) scales creation of VMs based off of a single fully configured one. Pay attention the naming convention highlighted in the script.

Handle WSL installation for Podman with below hints:

- Use "Turn Windows Features on or off" app to enable "Virtual Machine Platform" and "Windows Subsystem for Linux".
- Perform a VM restart
- kick off the WSL installation through powershell with below command:

```powershell
podman machine init
```

In some cases initial run of podman fails with missing hosts file. You may fix by adding the empty file C:\Users\{username}\.ssh\known_hosts.

Ensure a functional setup by running the [podman commands](../student/quest1.md#step-1-start-evilginx3-process) till evilginx starts.

### Required software

- [Git Client](https://git-scm.com/downloads)
- [PowerShell 7.4+](https://learn.microsoft.com/powershell/scripting/overview)
- [Podman (check box for WSLv2 installation if not present)](https://podman.io/docs/installation#windows)

## Create Azure Users

The shell script [provision-azure-users.sh](./env-prep/provision-azure-users.sh) creates arbitrary number of Azure users. The script uses the Azure CLI to create users and assign them to a group.

## Create SAP Users

Import the ABAP program [create-sap-users.abap](./env-prep/create-sap-users.abap) into the SAP system and use the [CSV file](./env-prep/users.csv) for mass user creation.
