#!/bin/bash

source ./env.sh

# Delete the resource group
az group delete --name "${RESOURCEGROUP_NAME}"

echo "Deleted resource group ${RESOURCEGROUP_NAME}"