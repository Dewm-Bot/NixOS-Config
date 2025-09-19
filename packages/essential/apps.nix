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
        fuse-7z-ng
        kdePackages.ark
        xarchiver
        py7zr
        peazip
    ];

    # Install firefox.
    programs.firefox.enable = true;
}


