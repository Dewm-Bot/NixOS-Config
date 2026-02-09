{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        uzdoom
        doomseeker
        zandronum
        doomrunner
        ringracers
        srb2
    ];
}


