{ config, pkgs, ... }:

{
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    
    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    

    # Wayland Configuration Stuff
    #services.displayManager.sddm.enable = true;
    #services.displayManager.sddm.wayland.enable = true;


    # XFCE
    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.desktopManager.xfce.enableWaylandSession = true;
    
    # Cosmic
    services.desktopManager.cosmic.enable = true;

    # Budgie
    #services.xserver.desktopManager.budgie.enable = true;
}


