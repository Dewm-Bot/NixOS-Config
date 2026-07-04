{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        uget
        onlyoffice-desktopeditors
        #bottles
        proton-vpn
        wireguard-tools
        openvpn
        openvpn3
        coppwr
        #rclone-ui
	alsa-tools
	fido2-manage
	yubikey-manager
	libfido2
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

    fonts.packages = with pkgs; [
        corefonts
    ];


}


