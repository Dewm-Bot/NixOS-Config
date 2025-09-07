{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sbctl
        floorp
        vulkan-tools
        gparted
        zed-editor
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


