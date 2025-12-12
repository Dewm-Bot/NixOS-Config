{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./game-streaming.nix
    ./display.nix
  ];
}
