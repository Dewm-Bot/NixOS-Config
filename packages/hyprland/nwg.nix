{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        nwg-look
        nwg-dock-hyprland
        nwg-panel
        nwg-drawer
        nwg-wrapper
        nwg-displays
        nwg-launchers
        nwg-icon-picker
        nwg-clipman
    ];
}


