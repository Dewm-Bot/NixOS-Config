{ config, pkgs, ... }:

{
  imports = [
    ./terminal.nix
    ./apps.nix
    ./hardware.nix
    ./managers.nix
  ];
}
