{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./obs.nix
  ];
}
