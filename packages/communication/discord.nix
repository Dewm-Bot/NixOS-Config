{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        #discord
        equicord
        equibop
        discordo
    ];
}


