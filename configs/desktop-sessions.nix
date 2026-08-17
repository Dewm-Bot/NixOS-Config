{ config, pkgs, ... }:

{
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    
    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = false;
    services.xserver.desktopManager.cinnamon.enable = true;
    

    # Wayland Configuration Stuff
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = false;
    programs.xwayland.enable = true;

    # Niri
    programs.niri.enable = true;

    # XFCE
    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.desktopManager.xfce.enableWaylandSession = true;
    
    # Cosmic
    services.desktopManager.cosmic.enable = true;

    # Budgie
    #services.desktopManager.budgie.enable = true;

    # Mango
    programs.mangowc = {
        enable = true;
        package = pkgs.mango; #WHY ARE THESE NOT NAMED THE SAME.
    };
}


