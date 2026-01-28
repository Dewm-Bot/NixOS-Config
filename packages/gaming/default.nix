{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./utils.nix
    ./emulation.nix
    ./doom.nix
    ./alvr.nix
  ];
}
