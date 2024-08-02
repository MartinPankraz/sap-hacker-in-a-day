# Quest 2 - Lure some phish

## Weaponize an email to cast out your bait

- Use the devious lure created before to craft a convincing email. Often, their content create a sense of urgency or curiosity to make the target click on the link and use fancy html to look professional. Maybe your SAP user is expiring soon and you need to renew access? 🤔there is a wealth of options there. Get creative or have a look online for inspiration.

> [!NOTE]
> The email should be convincing enough to make the target click on the link despite being flagged as [EXTERNAL] and all the other warning signs Outlook365 puts up. Sophisticated hacks try to capture internal accounts to send out baits from a trusted source. We are skipping this step for simplicity.

- Share your phishing result with the team for mutual learning.

- Finally, pull in your phish by either clicking the link from your received email or paste the URL into your browser.

## Enjoy your phish

1. Find the credentials and cookies in the Evilginx3 console. Use below command to list the sessions:

```bash
sessions 4
```

2. Copy the session cookie
3. Open a private browser window (note that some policy interfere with the login!) or better change browser to avoid conflicts with the current session. Alternatively, consider wiping the cookies from the current browser session (browsers developer tools).

> [!NOTE]
> Use any [browser extension](https://microsoftedge.microsoft.com/addons/detail/cookieeditor/neaplmfkghagebokkhpjpoebhdledlfi) to apply the cookie and impersonate the user.

4. Click Import and paste the cookie you copied from the Evilginx3 console.
5. Navigate to https://your-sap-domain:port/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=001&sap-language=EN#Shell-home and refresh the page.


## Where to next?

**[🏠Home](../README.md)** - [ Quest 3 >](quest3.md)

[🔝](#)
