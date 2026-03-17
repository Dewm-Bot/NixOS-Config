{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        tree
        git
        wget
        vulkan-tools
        nix-search-cli
        nh
        iotop
        htop
        fd
        fzf
        scrutiny
        killall
        libnotify
        fx
        dust
        pyenv
        toybox
        pciutils
        rclone
        davfs2
    ];

    #Tailscale
    services.tailscale.enable = true;
}


