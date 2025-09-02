{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
  };

  inputs.yeetmouse = {
    url = "github:AndyFilter/YeetMouse?dir=nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, yeetmouse, ... }:
    let
        system = "x86_64-linux;";
        pkgs = import nixpkgs {
            inherit system;
        config = {
            allowUnfree = true;
            };
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












