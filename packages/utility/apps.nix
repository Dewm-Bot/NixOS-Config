{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        uget
        onlyoffice-desktopeditors
        bottles
        protonvpn-gui
        wireguard-tools
        openvpn
        openvpn3
        coppwr
    ];

    networking.firewall.checkReversePath = false;

#    networking.networkmanager.plugins = [
#        networkmanager-fortisslvpn
#        networkmanager-iodine
#        networkmanager-l2tp
#        networkmanager-openconnect
#        networkmanager-openvpn
#        networkmanager-sstp
#        networkmanager-vpnc
#    ];



    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

    fonts.fonts = with pkgs; [
        corefonts
    ];


}


