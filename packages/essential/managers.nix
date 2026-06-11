{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        monitor
        resources
	xwayland-satellite
    ];

    xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;

        config = {
            common = {
            default = [ "hyprland" "gtk" ];
            };
        };

        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
	    pkgs.xdg-desktop-portal-gnome
        ];
    };
}


