{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./utils.nix
    ./caelestia
  ];
}
