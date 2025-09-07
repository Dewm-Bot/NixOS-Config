{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        wlogout
        wl-clipboard
        cliphist
    ];
}


