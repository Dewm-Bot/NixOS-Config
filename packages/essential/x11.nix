{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xorg.xrandr
        xorg.xinit
        xorg.x11perf
        xterm
        xorg.xprop
        xorg.xset
        xorg.xset
        xsettingsd
        xdg-utils
        xdg-launch
    ];
}


