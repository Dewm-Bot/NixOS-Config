{
  description = "Dewm's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/5dcf5e8";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; #Remove later, RIP
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release"; #New CachyOS Kernel Provider
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #Hardware specific fixes
    nix-alien.url = "github:thiagokokada/nix-alien"; #Probably unused now? Nix-LD seems to be better
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay"; #Fixes dolphin "Open With" menu without KDE-Plasma
    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nox = {
      url = "github:madsbv/nix-options-search";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-search-tv = {
      url = "github:3timeslazy/nix-search-tv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yeetmouse = {
      url = "github:AndyFilter/YeetMouse?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sls-steam = {
      url = "github:AceSLS/SLSsteam";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixos-hardware,
    nix-cachyos-kernel,
    nix-alien,
    zen-browser,
    nix4vscode,
    dolphin-overlay,
    yeetmouse,
    chaotic,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        nix4vscode.overlays.default
        dolphin-overlay.overlays.default
        ./overlays.nix
      ];
    };

  in
  {
    overlays = {
      pinned = nix-cachyos-kernel.overlays.default;
    };

    #Desktop
    nixosConfigurations.DewmBox-Nix = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit self system inputs; };

      modules = [
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ self.overlays.pinned ];
          boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;

          #Binary Cache
          nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
          nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
        })

        yeetmouse.nixosModules.default
        chaotic.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };

    #Laptop
    nixosConfigurations.DewmM16-Nix = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit self system inputs; };

      modules = [
        ({ pkgs, lib, ... }: {
          nixpkgs.overlays = [ self.overlays.pinned ];
          boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;

          #Binary Cache
          nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
          nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

          #Secureboot signing
          environment.systemPackages = [ pkgs.sbctl ];

        })

        yeetmouse.nixosModules.default
        chaotic.nixosModules.default
        nixos-hardware.nixosModules.asus-zephyrus-gu603h
        inputs.home-manager.nixosModules.home-manager
        ./laptop-conf.nix
      ];
    };
  };
}
