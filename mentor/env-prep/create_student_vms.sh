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
# Post install steps: git clone the repo to Desktop

resourceGroup="DSAG"  # Resource group for the VMs and PIPs
location="germanywestcentral"
vmSize="Standard_D4s_v3"
networkName="DSAG-vnet"
subnetName="default"
nsgName="saphackday00485"
vmPrefix="saphackday"
diskPrefix="saphackdayosdisk"
ipPrefix="saphackdaypip"
snapshotName="saphackday00-disk-snapshot"
diskPrefix="saphackdayosdisk"

# Loop to create VMs with public IPs from master OS disk snapshot
# Adjust number of VMs as needed
for i in $(seq -w 1 30)
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

  echo "VM $vmName creation initiated with Public IP $ipName."
done

echo "All VM creation requests submitted."
