{ config, pkgs, ... }:

{

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;    # Enable XWayland if needed
        withUWSM = true;           # Recommended to integrate with Systemd UWSM (Universal Wayland Session Manager)
    };

    environment.systemPackages = with pkgs; [
        xdg-desktop-portal-hyprland
        hyprlock
        hyprpaper
        hyprshot
        brightnessctl
        wofi
        rofi-wayland
        
    ];
}


