{ config, pkgs, ... }:

{
    programs.seahorse.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services = {
        greetd.enableGnomeKeyring = true;
        greetd-password.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
    };
    

    environment.systemPackages = with pkgs; [
        polkit_gnome
        hyprpolkitagent
        libsecret
        gnome-keyring
    ];

    services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; # <--- ADD THIS LINE HERE
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # ... any other portals you use
    ];
  };

}
