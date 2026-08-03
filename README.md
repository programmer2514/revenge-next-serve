# Revenge Next Build Server
A workflow that builds and serves the latest version of [Revenge Next](https://github.com/revenge-mod/revenge-bundle-next) via GitHub Pages.

Simplifies the process of installing and using Revenge Next by providing a dedicated server for the latest `revenge.bundle`.

Includes the [Revenge Next Experimental Plugins](https://github.com/palmdevs/revenge-next-plugins).

### To update to Revenge Next from Revenge Classic, follow these steps:

  1) In Revenge Classic, go to **Settings > Revenge**, and toggle on **Developer Settings**.

  2) Navigate back, and head into the **Developer** section.
  
  3) Edit the **Load from custom URL** field to point to `http://programmer2514.github.io/revenge-next-serve/revenge.bundle`.
  
  4) Restart Discord, and you should be running Revenge Next!

## Troubleshooting

Revenge Next is highly experimental.
I occasionally update this repository with custom patches to mitigate some issues, but things are still guaranteed to break from time to time.
If you need stability, I recommend sticking with Revenge Classic until Revenge Next is officially released.

### App crashes on startup

  - Update your app in Revenge Manager

### App crashes even after an update

  - Ensure your Discord version in Revenge Manager is set to Alpha, not Stable

### App still crashes on the latest Discord Alpha

  - Revenge Next is broken; Wait a few days, then update again

### Error messages appear on startup

  - Plugins are broken; Wait a few days, then restart your app

### I waited a few days and it still isn't fixed

  - Open an issue [here](https://github.com/programmer2514/revenge-next-serve/issues/new) and I will patch it; Don't bug the Revenge devs unless you are certain the issue is on their end
