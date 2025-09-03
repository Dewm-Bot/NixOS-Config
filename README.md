# NixOS-config
 Terrible....

> [!CAUTION]
> This repo is frequently worked on, be aware that this README may fall out of date.

## Hello, and welcome to my work-in-progress NixOS Config.

Currently, this build is a mix of nix files, and flakes. You should be able to build this config by using running the ``setup.sh`` script.

> [!IMPORTANT]
> If you are making changes to this repo, be sure to create a fork to allow for any additions to the repo folder to be properly tracked. You can use the ``test.sh`` script to make sure all files are included, and the ``build.sh`` script to skip the additional dry-run.
 
> [!NOTE]
> Currently this is being setup for a desktop with an AMD GPU, in the future, there will also be a config for a laptop using an Nvidia GPU. I do hope to have an additional config that switches it over to the Neauvo driver for better battery life and desktop use.

### Current Tree

```
.
├── amd-stuff.nix ---AMD specific, exclude from configuration.nix if need be.
├── build.sh
├── configs  
│   ├── audio.nix
│   ├── default.nix
│   ├── input.nix
│   ├── sessions.nix
│   └── system.nix
├── configuration.nix
├── flake.lock
├── flake.nix
├── packages ---Stores various packages, based on use-cases.
│   ├── audio
│   ├── communication
│   │   ├── default.nix
│   │   ├── discord.nix
│   │   └── microphone.nix
│   ├── default.nix ---Entrypoint for packages
│   ├── essential
│   │   ├── apps.nix
│   │   ├── default.nix
│   │   └── terminal.nix
│   ├── gamedev
│   │   ├── default.nix
│   │   └── github.nix
│   ├── gaming
│   │   ├── default.nix
│   │   ├── steam.nix
│   │   └── utils.nix
│   ├── hyprland
│   │   ├── caelestia
│   │   ├── default.nix
│   │   └── hyprland.nix
│   ├── terminal
│   │   ├── default.nix
│   │   └── fish.nix
│   └── tui
└── test.sh
```

> [!TIP]
> You can comment out package categories in default.nix in ./packages to exclude or include certain use cases. | You can also do the same within ./package/*/default.nix to exclude certain application groups, or copy application groups between use cases.






