#!/bin/bash

# Define variables
# Note: NSG manually created upfront and opened RDP port
# A master VM saphackday00 is created manually and a snapshot is taken upfront
# User name for student: dsag-gast and initial password: Welcome24#1234
#
# Required installs:
# - Git client (https://git-scm.com/downloads),
# - PowerShell 7.4+ (https://learn.microsoft.com/powershell/scripting/overview),
# - Podman (https://podman.io/docs/installation#windows)
#
# Post install steps:
# - git clone the repo to Desktop
# - run podman init sequence till evilginx shows up to ensure it is working
#
# Now scale the VMs using the script below

resourceGroup="DSAG"  # Resource group for the VMs and PIPs
location="germanywestcentral"  # Location for the VMs and PIPs
vmSize="Standard_D4s_v3"
# vmSize="Standard_D4s_v4"     # Alternative SKU size to use when your first SKU hits quota limits of e.g. 100
networkName="DSAG-vnet"
subnetName="default"
nsgName="saphackday00485"
vmPrefix="saphackday"
diskPrefix="saphackdayosdisk"
ipPrefix="saphackdaypip"
snapshotName="saphackday00-disk-snapshot"
diskPrefix="saphackdayosdisk"
sourceVM="saphackday00"
sourceVMRG="MGMT-GEWC-DEP01-INFRASTRUCTURE"

# Check if the snapshot exists
snapshotExists=$(az snapshot show --resource-group $resourceGroup --name $snapshotName --query "id" --output tsv 2>/dev/null)

if [ -z "$snapshotExists" ]; then
  # Deallocate the source VM
  az vm deallocate --resource-group $sourceVMRG --name $sourceVM

  # Retrieve the OS disk ID of the source VM
  osDiskId=$(az vm show \
    --resource-group $sourceVMRG \
    --name $sourceVM \
    --query "storageProfile.osDisk.managedDisk.id" \
    --output tsv)

  # Create the snapshot using the OS disk ID
  az snapshot create \
    --resource-group $resourceGroup \
    --name $snapshotName \
    --source $osDiskId \
    --query "id" --output tsv
else
  echo "Snapshot $snapshotName already exists."
fi

# Loop to create VMs with public IPs from master OS disk snapshot
# Adjust number of VMs as needed
for i in $(seq -w 1 10)
do
  vmName="${vmPrefix}${i}"
  diskName="${diskPrefix}${i}"
  ipName="${ipPrefix}${i}"

  # Create a managed disk from the snapshot
  az disk create \
    --resource-group $resourceGroup \
    --name $diskName \
    --location $location \
    --source $snapshotName \
    --query "id" --output tsv

  echo "Managed disk $diskName created."

  # Create a public IP address
  az network public-ip create \
    --resource-group $resourceGroup \
    --name $ipName \
    --location $location \
    --allocation-method Static \
    --sku Standard

  echo "Public IP $ipName created."

  # Create VM using the managed disk and attach the public IP
  az vm create \
    --resource-group $resourceGroup \
    --name $vmName \
    --location $location \
    --size $vmSize \
    --attach-os-disk $diskName \
    --os-type Windows \
    --vnet-name $networkName \
    --subnet $subnetName \
    --nsg $nsgName \
    --public-ip-address $ipName \
    --no-wait

  # Check if the VM creation command was successful
  if [ $? -ne 0 ]; then
    echo "Failed to create VM $vmName with Public IP $ipName."
    echo "Please check the error. In case you hit your 100 vCPU quota limit you might continue with another SKU"
    exit 1
  fi

  echo "VM $vmName creation initiated with Public IP $ipName."
done

echo "All VM creation requests submitted."
