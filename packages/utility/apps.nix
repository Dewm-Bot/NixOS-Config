{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        uget
        onlyoffice-desktopeditors
        bottles
        protonvpn-gui
        coppwr
        wireguard-tools
        openvpn
        openvpn3
    ];

    networking.firewall.checkReversePath = false;

    networking.networkmanager.plugins = [
        networkmanager-fortisslvpn
        networkmanager-iodine
        networkmanager-l2tp
        networkmanager-openconnect
        networkmanager-openvpn
        networkmanager-sstp
        networkmanager-vpnc

    ];



    nixpkgs.config.allowUnfreePredicate = pkg:


}


