{ config, pkgs, ... }:

{
  imports = [
    ./terminal.nix
    ./apps.nix
    ./exec.nix
    ./hardware.nix
    ./managers.nix
    ./fonts.nix
    ./kde-stuff.nix
    ./x11.nix
    ./keyrings.nix
  ];
}
