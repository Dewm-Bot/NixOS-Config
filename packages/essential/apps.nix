{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        sbctl
        floorp
        vulkan-tools
        gparted
        chromium
        inputs.zen-browser.packages."${system}".default # beta
        p7zip-rar
        kdePackages.ark
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


