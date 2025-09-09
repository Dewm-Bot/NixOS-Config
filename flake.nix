{
  description = "Dewm's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Bleeding edge packages from Chaotic-AUR
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

  };

  # bind `inputs` (so `inputs` is available below) while still getting named vars
  outputs = inputs@{ self, nixpkgs, nix4vscode, yeetmouse, chaotic, zen-browser, nixos-hardware, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        nix4vscode.overlays.default
        ./overlays.nix
      ];

    };
  in
  {
    nixosConfigurations.DewmBox-Nix = nixpkgs.lib.nixosSystem {
      inherit system;

      # Make the flake inputs available to module evaluation
      specialArgs = { inherit inputs; };

      modules = [
        # Add the `yeetmouse` input's NixOS Module to your system's modules:
        #yeetmouse.nixosModules.default
        chaotic.nixosModules.default
        ./configuration.nix
      ];

    };
    nixosConfigurations.DewmM16-Nix = nixpkgs.lib.nixosSystem {
      inherit system;

      # Make the flake inputs available to module evaluation
      specialArgs = { inherit inputs; };

      modules = [
        # Add the `yeetmouse` input's NixOS Module to your system's modules:
        yeetmouse.nixosModules.default
        chaotic.nixosModules.default
        nixos-hardware.nixosModules.asus-zephyrus-gu603h
        ./laptop-conf.nix
      ];
    };

  };
}

