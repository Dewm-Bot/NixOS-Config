{
  description = "Dewm's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/5dcf5e8";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; #Remove later, RIP
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release"; #New CachyOS Kernel Provider
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #Hardware specific fixes
    nix-alien.url = "github:thiagokokada/nix-alien"; #Probably unused now? Nix-LD seems to be better
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay"; #Fixes dolphin "Open With" menu without KDE-Plasma
    hyprland.url = "github:hyprwm/Hyprland";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

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
      #url = "github:caelestia-dots/shell";
      url = "github:caelestia-dots/shell/b334406";
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

    jackify = {
      url = "github:keygenesis/Jackify";
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
    nix-citizen,
    nix-gaming,
    ...
  }:
  let
    system = "x86_64-linux";

    globalOverlays = [
        inputs.nix4vscode.overlays.default
        inputs.dolphin-overlay.overlays.default
        inputs.nix-cachyos-kernel.overlays.default
        (import ./overlay.nix inputs) # Uncomment if you still use this file
      ];


      sharedModules = [
        #inputs.chaotic.nixosModules.default
        inputs.yeetmouse.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = globalOverlays;
          nixpkgs.config.allowUnfree = true;

          # Home Manager Setup
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          #Backup Old Configs
          home-manager.backupFileExtension = "backup";

          # Binary Cache
          nix.settings.substituters = [
          "https://attic.xuyh0120.win/lantian"
          "https://nix-citizen.cachix.org"
          ];
          nix.settings.trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
          ];
        }
      ];

    in
  {
    nixosConfigurations = {

      # --- DESKTOP ---
      DewmBox-Nix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          ./dewmbox-conf.nix #Main Entry (Desktop)
          ({ pkgs, ... }: {
            home-manager.extraSpecialArgs = { inherit inputs; deviceType = "desktop"; }; #Device Flag
            home-manager.users.dewm = import ./home.nix; #Base Home Manager Config

            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore; #CachyOS Kernel
          })
        ];
      };

        # --- LAPTOP ---
        DewmM16-Nix = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = sharedModules ++ [
            ./dewm-m16-conf.nix #Main Entry (Laptop)
            inputs.nixos-hardware.nixosModules.asus-zephyrus-gu603h

            ({ pkgs, ... }: {
              # Fix 1: Pass 'deviceType' inside the module
              home-manager.extraSpecialArgs = { inherit inputs; deviceType = "laptop"; }; #Device Flag
              home-manager.users.dewm = import ./home.nix; #Base Home Manager Config

              boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore; #CachyOS Kernel

              environment.systemPackages = [ pkgs.sbctl ]; #Secure Boot Signature Software
            })
          ];
        };
    };
  };
}
