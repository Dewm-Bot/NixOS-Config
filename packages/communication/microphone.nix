{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        easyeffects
    ];

    programs.dconf.enable = true;
}


