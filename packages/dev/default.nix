{ config, pkgs, ... }:

{
  imports = [
    ./android-studio.nix
    ./devbox.nix
    ./podman.nix
    ./direnv.nix
  ];
}

