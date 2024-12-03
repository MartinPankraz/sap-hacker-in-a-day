# Quest 3 - Analyze the catch with Sentinel for SAP and support remediation

[< Quest 2 ](quest2.md) - **[🏠Home](../README.md)** - [ Quest 4 >](quest4.md)

In quest 2 you were part of the red team and have compromised a login to SAP using the Fiori Launchpad. That action left a trail on the SAP audit log. Now, it's time to **switch to the blue team** and analyze the catch with Microsoft Sentinel for SAP and prepare to trigger automatic actions to support remediation.

## 🎯 Objectives

SIEM tools like [Microsoft Sentinel](https://learn.microsoft.com/azure/sentinel/) can pick up malicious activity, run automatic analytics on it, suggest remediation or act immediately yon it. In this quest, you will analyze your log entry, identify the out-of-the-box rule that fired on your activity, and create a playbook (aka [Azure LogicApps](https://learn.microsoft.com/azure/logic-apps/)) to forward the alert to your SOC ([Security Operations Center](https://www.microsoft.com/security/business/security-101/what-is-a-security-operations-center-soc)) Microsoft Teams channel for notification.

### Login to Azure Portal

Login with your user (e.g. user1@bestruncorp.onmicrosoft.com) to the [Azure Portal](https://portal.azure.com).
<p align="center" width="100%">
<img alt="Step 1" src="assets/quest3/3-1.png"  width="600">
</p>

### Open Microsoft Sentinel

In the search bar, enter "Sentinel", and click on Microsoft Sentinel under the search results.
<p align="center" width="100%">
<img alt="Step 2" src="assets/quest3/3-2.png"  width="600">
</p>

Microsoft Sentinel leverages Log Analytics Workspaces ([LAW](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-overview)) as a fundamental component for its operations. Essentially, Log Analytics Workspaces serve as a logical container for logs, enabling Sentinel to collect, analyze, and act on telemetry data from various sources, including Azure and on-premises environments.

Select the **dsagwslaw** LAW.
<p align="center" width="100%">
<img alt="Step 3" src="assets/quest3/3-3.png"  width="600">
</p>

### Inspect the SAP Audit Log data in Sentinel

Microsoft Sentinel uses the [Data Connector for SAP Solutions](https://learn.microsoft.com/azure/sentinel/sap/solution-overview) to enhance its monitoring and security capabilities for SAP systems. This integration allows Sentinel to ingest and analyze data from SAP environments, providing comprehensive visibility and threat detection across all layers of the SAP ecosystem.

Click **Data Connectors** from the navigation menu, select the **Microsoft Sentinel for SAP** connector from the list, and click on **Open connector page**.
<p align="center" width="100%">
<img alt="Step 4" src="assets/quest3/3-4.png"  width="600">
</p>

Select the **SAPAuditLog** entry from the data types collected by the connector.
<p align="center" width="100%">
<img alt="Step 5" src="assets/quest3/3-5.png"  width="600">
</p>

In the logs query start by changing the time range to the last 30 minutes.
<p align="center" width="100%">
<img alt="Step 6" src="assets/quest3/3-6.png"  width="600">
</p>

Microsoft Sentinel uses the Kusto Query Language ([KQL](https://learn.microsoft.com/azure/sentinel/kusto-overview)) extensively to perform various tasks such as searching, analyzing, and visualizing data. KQL is a powerful tool designed to work with large datasets in Azure, and it is used by several Azure services, including Azure Monitor, Azure Data Explorer, and Microsoft Sentinel.

To query the SAP Audit Log for logins of your user (e.g. user1@bestruncorp.onmicrosoft.com), change the KQL expression as by adding a *where* clause. Then click **Run**.
<p align="center" width="100%">
<img alt="Step 7" src="assets/quest3/3-7.png"  width="600">
</p>

Inspect the latest entry in the query result which shows the attacker's login with the stolen cookie of your user. Notice the *User* and *Computer* data fields. Since the IP address of the attacker is **NOT** in the range of your corporate network you will use this data to automate the threat detection with Sentinel.

Go back to the Sentinel main navigation menu by clicking the link in the breadcrumb navigation.
<p align="center" width="100%">
<img alt="Step 8" src="assets/quest3/3-8.png"  width="600">
</p>

### Automate threat detection for the scenario with an Analytic Rule

Sentinel uses built-in and custom analytics rules to detect threats. These rules are based on known attack patterns and behaviors, and they continuously analyze data from various sources to identify suspicious activities.

Let's start this journey by inspecting the current entries for the expected network ranges of *legitimate* login requests to your SAP system.

Select **Watchlist** from the navigation menu and enter "Networks" in the search bar. Click on "SAP - Networks" from the search results.

Click the **Update watchlist** button and select **Edit watchlist items**.
<p align="center" width="100%">
<img alt="Step 9" src="assets/quest3/3-9.png"  width="600">
</p>

The **SAP - Networks** watchlist currently contains one entry which represents the network range of IP addresses of *authorized clients* from the corporate network. Leave the entry as-is and go back to the main menu by clicking the **Microsoft Sentinel** entry in the breadcrumb navigation.
<p align="center" width="100%">
<img alt="Step 10" src="assets/quest3/3-10.png"  width="600">
</p>

Select **Analytics** from the menu and switch to the **Rule templates** tab.

Search for a built-in rule template to detect logins from unexpected networks by entering "Login from" in the search bar. On the "SAP - Login from unexpected network" built-in rule, select **Create rule**. 
<p align="center" width="100%">
<img alt="Step 11" src="assets/quest3/3-11.png"  width="600">
</p>

Change the name of your new analytic rule by adding your user name to it, e.g. "SAP - **User1** login from unexpected network". Optionally, change the description accordingly.

Click **Next: Set rule logic**.
<p align="center" width="100%">
<img alt="Step 12" src="assets/quest3/3-12.png"  width="600">
</p>

Select the default Kusto query from the built-in rule and copy it to the clipboard. 
<p align="center" width="100%">
<img alt="Step 13" src="assets/quest3/3-13.png"  width="600">
</p>

To avoid interference with the other users we only want to detect threats for your specific user. Therefore, the query must be changed accordingly.

You can seek help from [Microsoft Copilot](https://copilot.microsoft.com/) by entering the a prompt like *"How do I change the following Kusto query to filter only audit log message for a specific user?"*, followed by the built-in query you copied before to the clipboard.  
<p align="center" width="100%">
<img alt="Step 14" src="assets/quest3/3-14.png"  width="600">
</p>

Copilot will add the required expressions to the built-in query. Check the proposed query to see if it fits and copy it into the clipboard.
<p align="center" width="100%">
<img alt="Step 15" src="assets/quest3/3-15.png"  width="600">
</p>

Replace the rule logic with the Copilot proposal from the clipboard. 

Change the placeholder in the variable definition (here "your_specific_user")

```bash
let specificUser = "your_specific_user"
```

with your SAP user name, e.g. *"USER1"*.

Click **Add new** to add a new data field to the alert custom details. Enter the name _GeoLocation_ for it, and select the _GeoLocation_ event parameter from the drop-down list.

<p align="center" width="100%">
<img alt="Step 16" src="assets/quest3/3-15-1.png"  width="600">
</p>

Change the **Query scheduling** settings to run the query every 5 minutes on SAP Audit Log data not older than 30 minutes. This time range should cover the audit log data captured from the successful attack at the end of [Quest 2](quest2.md).

Click **Next: Incident settings**.
<p align="center" width="100%">
<img alt="Step 16" src="assets/quest3/3-16.png"  width="600">
</p>

Leave the settings unchanged and click **Next: Automated response**.
<p align="center" width="100%">
<img alt="Step 17" src="assets/quest3/3-17.png"  width="600">
</p>

Create a new automation rule for sending the notification to the SOC via Microsoft Teams by clicking **Add new**.

> [!CAUTION]
> Create the rule first without automation to avoid errors in the rule creation process. Reopen it afterwards and add the automation then.

<p align="center" width="100%">
<img alt="Step 18" src="assets/quest3/3-18.png"  width="600">
</p>

Enter a name for your rule that identifies the user, e.g. *"User1 - Send notification to Teams"*. Make sure that the **Conditions** to run the _automation rule_ set the _Analytic rule name_ to the _Current rule_.

Select **Run playbook** from **Actions**.

Select the playbook for your user (e.g. *PlaybookUnexpectedNetworkLogin**User1***) from the list of playbooks. You will take a closer look at the playbook in [Quest 5](quest5.md) and enhance it with additional logic.

Click **Apply**.
<p align="center" width="100%">
<img alt="Step 19" src="assets/quest3/3-19.png"  width="600">
</p>

Click **Next: Review + create**.
<p align="center" width="100%">
<img alt="Step 20" src="assets/quest3/3-20.png"  width="600">
</p>

After the validation has passed, click **Save**.
<p align="center" width="100%">
<img alt="Step 21" src="assets/quest3/3-21.png"  width="600">
</p>

You've created a new analytics rule for the attack scenario.

<p align="center" width="100%">
<img alt="Step 22" src="assets/quest3/3-22.png"  width="600">
</p>

Let's see the new rule in action!

### Investigate the Playbook run history

First we check if the Playbook referenced in the new rule has been triggered by the creation of a new incident for the login from an unexpected network.

In the Azure Portal search bar, enter "Logic" and select **Logic apps** from the search results.

<p align="center" width="100%">
<img alt="Step 23" src="assets/quest3/3-23.png"  width="600">
</p>

Click on the Playbook's Logic app of your rule and user, e.g. _PlaybookUnexpectedNetworkLogin**User1**_

<p align="center" width="100%">
<img alt="Step 24" src="assets/quest3/3-24.png"  width="600">
</p>

Check the start time and status of the latest entry in the *Run history* to verify that the Logic app has been triggered successfully. It may take up to 5 minutes based on your rule schedule until the the Logic app runs for the first time.

> [!TIP]
> Hit **Refresh** to update the run history for new entries.

<p align="center" width="100%">
<img alt="Step 25" src="assets/quest3/3-25.png"  width="600">
</p>

Click on the trigger action with the name **Microsoft Sentinel Incident** to see more details of the rule execution.

<p align="center" width="100%">
<img alt="Step 26" src="assets/quest3/3-26.png"  width="600">
</p>

In the *body* section, scroll down to find the incident's ID that triggered the rule.

<p align="center" width="100%">
<img alt="Step 27" src="assets/quest3/3-27.png"  width="600">
</p>

### Check the notification in Teams

Finally, login to [Microsoft Teams](https://teams.microsoft.com) with the SOC user **sapsentinel@bestruncorp.onmicrosoft.com**. Login with the same password as for your user.

<p align="center" width="100%">
<img alt="Step 28" src="assets/quest3/3-28.png"  width="600">
</p>

Enter "ID <ID of your incident, e.g. 56>" in the search bar.

<p align="center" width="100%">
<img alt="Step 29" src="assets/quest3/3-29.png"  width="600">
</p>

Click on the message in the search results.

<p align="center" width="100%">
<img alt="Step 30" src="assets/quest3/3-30.png"  width="600">
</p>

The playbook posted an [Adaptive Card](https://learn.microsoft.com/adaptive-cards/) to teams with a deep link to the generated incident in the Azure Portal.

Click on the **incident link**.

<p align="center" width="100%">
<img alt="Step 31" src="assets/quest3/3-31.png"  width="600">
</p>

The link takes you directly to the incident details in Sentinel.

<p align="center" width="100%">
<img alt="Step 32" src="assets/quest3/3-32.png"  width="600">
</p>

Congratulations for completing quest 3!

> [!TIP]
> In case you are curious about automatically blocking the compromised SAP user, check this blog series on [Sentinel for SAP - SOAR](https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/from-zero-to-hero-security-coverage-with-microsoft-sentinel-for-your/ba-p/13561790). It shows how to use the built-in playbooks of the Sentinel for SAP solution for that matter.

## Update the [leaderboard](https://martinpankraz.github.io/crispy-potato/) with your progress⏱

## Claiming your reward

🏆Finish [quest 3](quest3.md), and claim [your badge](https://dsagwsrgb4f3.z1.web.core.windows.net/).

> [!TIP]
> Open the developer tools <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>i</kbd> on that website to find the passphrase on the website code. Search for "secret". 😎 May the ninja-cat be with you.

## Where to next?

[< Quest 2 ](quest2.md) - **[🏠Home](../README.md)** - [ Quest 4 >](quest4.md)

[🔝](#)
