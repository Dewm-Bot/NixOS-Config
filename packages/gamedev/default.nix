{ config, pkgs, ... }:

{
  imports = [
    ./github.nix
    ./vscodium.nix
    ./jetbrains.nix
  ];
}

