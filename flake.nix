{
  description = "Dewm's NixOS Flake'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
        url = "github:nix-community/nix4vscode";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";
    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-cli.inputs.nixpkgs.follows = "nixpkgs";

    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs";

    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";
  };

    inputs.yeetmouse = {
        url = "github:AndyFilter/YeetMouse?dir=nix";
        inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, yeetmouse, nix4vscode, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
                nix4vscode.overlays.default            
            ];
        };
    in
{
    nixosConfigurations.DewmBox-Nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system; };
        modules = [
            # Add the `yeetmouse` input's NixOS Module to your system's modules:
            yeetmouse.nixosModules.default
            ./configuration.nix
            
        ];
    };
  };
}












