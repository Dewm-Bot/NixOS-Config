{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xrandr
        xinit
        x11perf
        xterm
        xprop
        xset
        xsettingsd
        xdg-utils
        xdg-launch
        xhost
    ];
}


