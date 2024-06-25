# Quest 1 - Buckle up!

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

In this tutorial, you will perform basic deployments to set up your environment for the hands-on lab. You will also learn how to install a phishing simulation tool to prepare for the next quest.

> [!TIP]
> Keep a bookmark to this repository to support you in your journey.

## Legend

We'll have some notes for you as you go:

> [!TIP]
> A tip will provide with some further information and insights.

> [!IMPORTANT]
> An 'Important' box will will provide some instructions for this tutorial.

## Prerequisites

- **Azure Subscription**: If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/).
- **A machine with enough rights** to download, install and run the required software. Often this ends up being local admin rights.
- **Setup a phishing simulation tool** of your choice. Following screenshots and video references refer to Evilginx3.
- **A phishing target**: This could be a test account and sandbox system that has a web experience with your Identity Provider (IdP) configured for login. We will use a sample SAP system and Microsoft Entra ID for this tutorial.
- **A Sentinel for SAP instance**: Learn more about the free trial [here](https://azure.microsoft.com/pricing/offers/microsoft-sentinel-sap-promo/).
- **An SAP instance connected to Sentinel for SAP**: Learn more about how to onboard [here](https://learn.microsoft.com/azure/sentinel/sap/deployment-overview).

> [!TIP]
> Optionally, configure your [Entra ID instance to enforce MFA](https://learn.microsoft.com/entra/identity/authentication/tutorial-enable-azure-mfa). This will help you to see how the phishing simulation tool can be used to bypass MFA.

## Installation for hands-on lab

### Step 1: Clone the repository

´´´bash
git clone https://github.com/kgretzky/evilginx2.git
´´´

### Step 2: Install Evilginx3

´´´bash
cd evilginx2
sudo apt-get install golang-go
go get -u github.com/kgretzky/evilginx2
cd $GOPATH/src/github.com/kgretzky/evilginx2
go build
´´´

## Where to next?

**[🏠Home](../README.md)** - [ Quest 2 >](quest2.md)

[🔝](#)
