{ config, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./microphone.nix
  ];
}
