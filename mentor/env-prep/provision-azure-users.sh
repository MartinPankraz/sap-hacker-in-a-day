#! /bin/bash

randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}

source ./env.sh

RG_ID=$(az group show -n ${RESOURCEGROUP_NAME} -o tsv --query id)

# Create user group
az ad group create \
    --display-name "MicroHack Users" \
    --mail-nickname "MicroHackUsers" > group_details.json 

# Get the group id
GROUP_ID=$(az ad group show --group "MicroHack Users" --query id -o tsv)

echo "Created group MicroHack Users with id $GROUP_ID"

# Assign the group to the resource group
az role assignment create \
    --assignee $GROUP_ID \
    --role "Contributor" \
    --scope $RG_ID

# Create users
for i in $(seq 1 $NUMBER_OF_USERS);
do
    PASSWORD=$FIX_PASSWORD #$(randpw)
    USER_PRINCIPAL_NAME="${USERNAME_SUFFIX}${i}@${TENANT_DOMAIN}"

    az ad user create \
        --display-name "MicroHack Participant ${i}" \
        --password "${PASSWORD}" \
        --user-principal-name ${USER_PRINCIPAL_NAME} > ${USERNAME_SUFFIX}${i}_details.json

    echo "Created user ${USER_PRINCIPAL_NAME}"

    echo $PASSWORD > ${USERNAME_SUFFIX}${i}_password.txt
    
    # Add user to group
    az ad group member add --group "MicroHack Users" --member-id $(jq -r .id ${USERNAME_SUFFIX}${i}_details.json)
done
