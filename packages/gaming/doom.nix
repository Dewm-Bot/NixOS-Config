{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gzdoom
        #doomseeker
        #zandronum
        doomrunner
        ringracers
        srb2
    ];
}


