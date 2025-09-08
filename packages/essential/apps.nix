{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        sbctl
        floorp
        vulkan-tools
        gparted
        zed-editor
        chromium
        inputs.zen-browser.packages."${system}".default # beta
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


