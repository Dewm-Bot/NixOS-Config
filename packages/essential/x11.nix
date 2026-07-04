{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xrandr
        xinit
        x11perf
        xterm
        xprop
        xset
        xset
        xsettingsd
        xdg-utils
        xdg-launch
        xhost
    ];
}


