# Quest 6 - Destroy evidence of your evil deeds

[< Quest 5 ](quest5.md) - **[🏠Home](../README.md)**

## Clean up the files you created during this tutorial

* Revert the [hosts file](C:\Windows\System32\drivers\etc) changes.
* Remove the certificate you added to the trusted root certification authorities:
    * One way to get there is <kbd>windows</kbd>+<kbd>r</kbd> and type `certmgr.msc` to open the certificate manager.
    * Navigate to `Trusted Root Certification Authorities` > `Certificates`.
    * Find the Evilginx certificate and delete it.
* Remove the cookie extension from your browser.
* Destroy the virtual environment or delete your resources in Azure. At least stop them to avoid using further free credits.
* Stop Docker/Podman containers if you used them `docker stop my-evilginx-container` or `podman stop my-evilginx-container`.
* Removing the phishing simulation tool from your machine.

> [!TIP]
> Don't forget to [claim your badge](https://webhostingforconverter.z16.web.core.windows.net/claim-reward.html) for completing this lab!

## Update the [leaderboard](https://forms.office.com/r/aYH8rh7vp5) with your progress⏱

## Where to next?

[< Quest 5 ](quest5.md) - **[🏠Home](../README.md)**

[🔝](#)
