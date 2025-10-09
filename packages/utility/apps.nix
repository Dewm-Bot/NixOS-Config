{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        uget
        onlyoffice-desktopeditors
        bottles
        protonvpn-gui
    ];



    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

    fonts.fonts = with pkgs; [
        corefonts
    ];
}


