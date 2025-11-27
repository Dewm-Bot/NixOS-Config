{ config, pkgs, inputs, ... }:
{

    imports = [inputs.hyprland.nixosModules.default]; #Use Upstream Hyprland

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
    plugins = with pkgs.hyprlandPlugins; [
        hyprexpo
        hyprsplit
        hyprspace
        hyprscrolling
        csgo-vulkan-fix
    ];
    settings = {
    };
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







}
