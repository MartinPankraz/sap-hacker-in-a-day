#! /bin/bash

source ./env.sh

# Delete users
for i in $(seq 1 $NUMBER_OF_USERS);
do
    # Delete user
    az ad user delete --id $(jq -r .id ${USERNAME_SUFFIX}${i}_details.json)

    echo "Deleted user ${USERNAME_SUFFIX}${i}"
done

# Delete group
az ad group delete --group "MicroHack Users"
echo "Deleted group MicroHack Users"