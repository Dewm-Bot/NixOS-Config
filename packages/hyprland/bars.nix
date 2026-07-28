{ config, pkgs, inputs, ... }:
{
    environment.systemPackages = with pkgs; [
        waybar
        waybar-mpris
        gpu-usage-waybar
        wttrbar
        mako
	noctalia
	wayle
    ];
}

