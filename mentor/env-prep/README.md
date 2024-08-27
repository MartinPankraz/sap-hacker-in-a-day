This folder contains the scripts to automate the setup for the workshop.

## Step 1: Configure environment variables
Configure your environment variables with the file [env.sh](./env.sh).

For your Teams Channel ID (parameter `TEAMS_GROUP_ID`), login to Teams, go to your Teams channel, click on the context menu, and select **Get link to channel**. Copy the group id from the link:

<p align="center" width="100%">
<img alt="Setup connection" src="groupid.png"  width="600">
</p>

Copy the Channel ID from the same link. [URL-decode](https://www.urldecoder.io/) the string before saving it in the env.sh file.

<p align="center" width="100%">
<img alt="Setup connection" src="channelid.png"  width="600">
</p>

## Step 2: Login to Azure
In a Linux shell, run `az login`

## Step 3: Provision users in Entra ID tenant
Change the directory to `.\mentor\env-prep`.

Run the script [`.\provision-azure-users.sh`](./provision-azure-users.sh)

## Step 4: Deploy playbooks
Run the script [`.\deploy_playbooks.sh`](./deploy_playbooks.sh)

Upon successful deployment of the resources, go to the newly created resource group in the [Azure Portal](https://portal.azure.com) and open the API connection `teams`. Select **General -> Edit API connection** and click **Authorize**. Login to Entra ID with the user used for the Teams connection. Click **Save**.

<p align="center" width="100%">
<img alt="Setup connection" src="auth_conn.png"  width="600">
</p>

## Step 5: Provision users in SAP
- Login to SAP (e.g. with user DEVELOPER in a CAL instance)
- Run SE38
- Create a new ABAP program with file [`create-sap-users.abap`](./create-sap-users.abap)
- Edit file [`users.csv`](./users.csv) according to the number of users
- Run the ABAP program from SE38