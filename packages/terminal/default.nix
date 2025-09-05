{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./tty.nix
    ./utils.nix
  ];
}
