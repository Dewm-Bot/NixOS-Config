# NixOS-config
 Terrible....

## Hello, and welcome to my work-in-progress NixOS Config.

Currently, this build is a batch of loose files and flakes. You should be able to build this config by using the following command:

``sudo nixos-rebuild switch --flake /etc/nixos/#DewmBox-Nix ``

> [!IMPORTANT]
> Make sure to change the directory in this statement, to wherever these files reside. 

> [!NOTE]
> Currently this is being setup for a desktop with an AMD GPU, in the future, there will also be a config for a laptop using an Nvidia GPU. I do hope to have an additional config that switches it over to the Neauvo driver for better battery life and desktop use.

### Current Tree

```
├── amd-stuff.nix #Exclude this file from configuration.nix to get rid of amd-specific configs
├── configuration.nix #NEEDS TO BE REWORKED
├── dewm-stuff.nix #Temp, and to be removed
├── flake.lock
├── flake.nix 
├── packages #Stores various packages, based on use-cases. 
│   ├── communication
│   ├── default.nix #Entrypoint
│   ├── essential
│   │   ├── default.nix
│   │   └── terminal.nix
│   ├── gamedev
│   │   ├── default.nix
│   │   └── github.nix
│   ├── gaming
│   │   ├── default.nix
│   │   └── steam.nix
│   ├── hyprland
│   │   └── caelestia
│   ├── terminal
│   │   ├── default.nix
│   │   └── fish.nix
│   └── tui
```

> [!TIP]
> You can comment out package categories in default.nix in ./packages to exclude or include certain use cases. | You can also do the same within ./package/*/default.nix to exclude certain application groups, or copy application groups between use cases.



> [!CAUTION]
> This repo is frequently worked on, be aware that this README may fall out of date.


