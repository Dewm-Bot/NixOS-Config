{ config, pkgs, ... }:
{

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;    # Enable XWayland if needed
        withUWSM = true;           # Recommended to integrate with Systemd UWSM (Universal Wayland Session Manager)
    };

    environment.systemPackages = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
        hyprlock
        hyprpaper
        hyprshot
        brightnessctl
        wofi
        rofi
        hyprpolkitagent
	grimblast
	ashell
	hyprpanel
	waypaper       
    ];

    environment.sessionVariables = {
        HYPR_PLUGIN_DIR = pkgs.symlinkJoin {
                name = "hyprland-plugins";
                paths = with (pkgs.hyprlandPlugins or {}); [
                        hyprexpo
                        hyprsplit
                        hyprspace
                        hyprscrolling
                        csgo-vulkan-fix
                ];
        };
     };

}
