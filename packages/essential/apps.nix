{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sbctl
        floorp
        vulkan-tools
        gparted
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


