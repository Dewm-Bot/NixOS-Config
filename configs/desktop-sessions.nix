{ config, pkgs, ... }:
let
    sddm-astronaut = pkgs.sddm-astronaut.override {
        embeddedTheme = "pixel_sakura";
        #themeConfig = {
        #  Background = "path/to/background.jpg";
        #  Font = "M+1 Nerd Font";
        #};
    };

in {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    
    # Enable the Cinnamon Desktop Environment.
    #services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    

    # Wayland Configuration Stuff
    programs.xwayland.enable = true;


    # XFCE
    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.desktopManager.xfce.enableWaylandSession = true;
    
    # Cosmic
    services.desktopManager.cosmic.enable = true;

    # Budgie
    #services.xserver.desktopManager.budgie.enable = true;


    #Config Stuff
    #SDDM
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
            sddm-astronaut
        ];

        theme = "sddm-astronaut-theme";
            settings = {
                Theme = {
                    Current = "sddm-astronaut-theme";
                };
            };
    };

    environment.systemPackages = with pkgs; [
        kdePackages.breeze
        kdePackages.breeze-gtk
        sddm-astronaut
        kdePackages.qtbase
        kdePackages.qtsvg
        kdePackages.qtdeclarative
        kdePackages.qtmultimedia
    ];
}


