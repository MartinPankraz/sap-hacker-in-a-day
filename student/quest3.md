# Quest 3 - Analyze the catch with Sentinel for SAP and support remediation

[< Quest 2 ](quest2.md) - **[🏠Home](../README.md)** - [ Quest 4 >](quest4.md)

In quest 2 you have logged in to SAP using the Fiori Launchpad. That action leaves a trail on the SAP audit log. SIEM tools like [Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/) can pick this up and run automatic analytics on it. In this quest, you will analyze your log entry, identify the out-of-the-box rule that fired on your activity, and create a playbook (aka [Azure LogicApps](https://learn.microsoft.com/en-us/azure/logic-apps/)) to forward the alert to your SOC ([Security Operations Center](https://www.microsoft.com/en-us/security/business/security-101/what-is-a-security-operations-center-soc)) Microsoft Teams channel for notification.

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

Microsoft Sentinel leverages Log Analytics Workspaces ([LAW](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)) as a fundamental component for its operations. Essentially, Log Analytics Workspaces serve as a logical container for logs, enabling Sentinel to collect, analyze, and act on telemetry data from various sources, including Azure and on-premises environments.

Select the **dsagwslaw** LAW.
<p align="center" width="100%">
<img alt="Step 3" src="assets/quest3/3-3.png"  width="600">
</p>

### Inspect the SAP Audit Log data in Sentinel
Microsoft Sentinel uses the [Data Connector for SAP Solutions](https://learn.microsoft.com/en-us/azure/sentinel/sap/solution-overview) to enhance its monitoring and security capabilities for SAP systems. This integration allows Sentinel to ingest and analyze data from SAP environments, providing comprehensive visibility and threat detection across all layers of the SAP ecosystem.

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

Microsoft Sentinel uses the Kusto Query Language ([KQL](https://learn.microsoft.com/en-us/azure/sentinel/kusto-overview)) extensively to perform various tasks such as searching, analyzing, and visualizing data. KQL is a powerful tool designed to work with large datasets in Azure, and it is used by several Azure services, including Azure Monitor, Azure Data Explorer, and Microsoft Sentinel.

To query the SAP Audit Log for logins of your user (e.g. user1@bestruncorp.onmicrosoft.com), change the KQL expression as by adding a *where* clause. Then click **Run**.
<p align="center" width="100%">
<img alt="Step 7" src="assets/quest3/3-7.png"  width="600">
</p>

### Step 8: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 8" src="assets/quest3/3-8.png"  width="600">
</p>

### Step 9: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 9" src="assets/quest3/3-9.png"  width="600">
</p>

### Step 10: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 10" src="assets/quest3/3-10.png"  width="600">
</p>

### Step 11: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 11" src="assets/quest3/3-11.png"  width="600">
</p>

### Step 12: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 12" src="assets/quest3/3-12.png"  width="600">
</p>

### Step 13: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 13" src="assets/quest3/3-13.png"  width="600">
</p>

### Step 14: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 14" src="assets/quest3/3-14.png"  width="600">
</p>

### Step 15: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 15" src="assets/quest3/3-15.png"  width="600">
</p>

### Step 16: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 16" src="assets/quest3/3-16.png"  width="600">
</p>

### Step 17: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 17" src="assets/quest3/3-17.png"  width="600">
</p>

### Step 18: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 18" src="assets/quest3/3-18.png"  width="600">
</p>

### Step 19: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 19" src="assets/quest3/3-19.png"  width="600">
</p>

### Step 20: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 20" src="assets/quest3/3-20.png"  width="600">
</p>

### Step 21: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 21" src="assets/quest3/3-21.png"  width="600">
</p>

### Step 22: Lorem ipsum
Lorem ipsum
<p align="center" width="100%">
<img alt="Step 22" src="assets/quest3/3-22.png"  width="600">
</p>

## Where to next?

[< Quest 2 ](quest2.md) - **[🏠Home](../README.md)** - [ Quest 4 >](quest4.md)

[🔝](#)
