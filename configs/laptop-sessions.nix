{ config, pkgs, ... }:

{
    imports = [ ./sddm.nix ];

    services.displayManager.sddm.wayland = {
        enable = true;
        compositorCommand = "labwc";
    };

    programs.xwayland.enable = true;

    # Desktop Environments
    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.desktopManager.xfce.enableWaylandSession = true;
    services.desktopManager.cosmic.enable = true;
    services.desktopManager.budgie.enable = true;
    programs.mango = {
        enable = true;
    };
}
