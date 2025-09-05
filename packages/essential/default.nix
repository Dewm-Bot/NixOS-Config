{ config, pkgs, ... }:

{
  imports = [
    ./terminal.nix
    ./apps.nix
    ./hardware.nix
    ./managers.nix
    ./fonts.nix
    ./kde-stuff.nix
  ];
}
