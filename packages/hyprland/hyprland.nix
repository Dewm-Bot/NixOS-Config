{ config, pkgs, inputs, ... }:
{


     imports = [inputs.hyprland.nixosModules.default]; #Use Upstream Hyprland

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
    };

    environment.systemPackages = with pkgs; [
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
        ironbar
        nwg-panel
        nwg-drawer
    ];

}
