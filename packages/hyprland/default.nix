{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./caelestia
    ./utils.nix
  ];
}
