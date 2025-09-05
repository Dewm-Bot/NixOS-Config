{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        foot
        kitty
        zellij
        tmux
        byobu
    ];


}


