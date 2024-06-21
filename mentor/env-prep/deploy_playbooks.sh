#!/bin/bash

source ./env.sh

# Base name for the playbook instances
base_name="PlaybookLoginFromUnexpectedNetworkUser"

# Template file
template_file="playbook.json"

# Create the resource group
az group create --name "${RESOURCEGROUP_NAME}" --location "${LOCATION}"

echo "Created resource group ${RESOURCEGROUP_NAME}"

# Deploy playbook connections
az deployment group create --resource-group "${RESOURCEGROUP_NAME}" \
  --template-file "playbook_conn_azuresentinel.json" \
  --parameters "{\"subscriptionId\": {\"value\": \"${SUBSCRIPTION_ID}\"}}" \
  --parameters "{\"resourceGroup\": {\"value\": \"${RESOURCEGROUP_NAME}\"}}" \
  --parameters "{\"location\": {\"value\": \"${LOCATION}\"}}"

echo "Deployed azuresentinel connection"
  
az deployment group create --resource-group "${RESOURCEGROUP_NAME}" \
  --template-file "playbook_conn_teams.json" \
  --parameters "{\"tenantId\": {\"value\": \"${TENANT_ID}\"}}" \
  --parameters "{\"subscriptionId\": {\"value\": \"${SUBSCRIPTION_ID}\"}}" \
  --parameters "{\"resourceGroup\": {\"value\": \"${RESOURCEGROUP_NAME}\"}}" \
  --parameters "{\"location\": {\"value\": \"${LOCATION}\"}}"
  
echo "Deployed teams connection"

# Loop to deploy playbooks for quest 3
for i in $(seq 1 $NUMBER_OF_USERS); do
  # Define the new playbook name
  playbook_name="${base_name}${i}"
  
  az deployment group create --resource-group "${RESOURCEGROUP_NAME}" \
    --template-file "playbook_quest3.json" \
    --parameters "{\"playbookName\": {\"value\": \"${playbook_name}\"}}" \
    --parameters "{\"subscriptionId\": {\"value\": \"${SUBSCRIPTION_ID}\"}}" \
    --parameters "{\"resourceGroup\": {\"value\": \"${RESOURCEGROUP_NAME}\"}}" \
    --parameters "{\"location\": {\"value\": \"${LOCATION}\"}}" \
    --parameters "{\"teamsGroupId\": {\"value\": \"${TEAMS_GROUP_ID}\"}}" \
    --parameters "{\"teamsChannelId\": {\"value\": \"${TEAMS_CHANNEL_ID}\"}}"
  
  echo "Deployed ${playbook_name} to resource group ${RESOURCEGROUP_NAME}"
done

# Deploy sample solution for quest 5
az deployment group create --resource-group "${RESOURCEGROUP_NAME}" \
  --template-file "playbook_quest5.json" \
  --parameters "{\"playbookName\": {\"value\": \"DO_NOT_USE_PlaybookLoginFromUnexpectedNetwork_Quest5\"}}" \
  --parameters "{\"subscriptionId\": {\"value\": \"${SUBSCRIPTION_ID}\"}}" \
  --parameters "{\"resourceGroup\": {\"value\": \"${RESOURCEGROUP_NAME}\"}}" \
  --parameters "{\"location\": {\"value\": \"${LOCATION}\"}}" \
  --parameters "{\"teamsGroupId\": {\"value\": \"${TEAMS_GROUP_ID}\"}}" \
  --parameters "{\"teamsChannelId\": {\"value\": \"${TEAMS_CHANNEL_ID}\"}}" \
  --parameters "{\"openaiModelName\": {\"value\": \"${OPENAI_MODEL_NAME}\"}}" \
  --parameters "{\"openaiResourceName\": {\"value\": \"${OPENAI_RESOURCE_NAME}\"}}" \
  --parameters "{\"openaiApiKey\": {\"value\": \"${OPENAI_API_KEY}\"}}"
