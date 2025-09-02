{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vulkan-tools
    hyprland
    sbctl
    floorp
    equicord
  ];


    #Hardware Config Stuff
    hardware.yeetmouse = {
        enable = true;
        sensitivity = 1.0;
    };


}


