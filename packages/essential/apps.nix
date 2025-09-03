{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sbctl
        floorp
        vulkan-tools
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


