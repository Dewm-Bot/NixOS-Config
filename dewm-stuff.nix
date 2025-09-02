{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    nix-search-cli
    mesa
    amdvlk
    vulkan-tools
    steamtinkerlaunch
    steam
    hyprland
    sbctl
    floorp
    equicord
    git
  ];


    programs.steam.enable = true;

   





    #Hardware Config Stuff
    hardware.yeetmouse = {
        enable = true;
        sensitivity = 1.0;
    };


}


