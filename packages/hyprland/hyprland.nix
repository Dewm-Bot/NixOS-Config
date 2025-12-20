{ config, pkgs, inputs, ... }:
{

     imports = [inputs.hyprland.nixosModules.default]; #Use Upstream Hyprland

#     programs.hyprland = {
#         enable = true;
#         xwayland.enable = true;
#         withUWSM = true;
#     plugins = [
#         inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
#         pkgs.hyprlandPlugins.hyprsplit
#         pkgs.hyprlandPlugins.hyprspace
#         inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
#         inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix
#     ];
#     settings = {
#     };
#   };

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	plugins = with pkgs.hyprlandPlugins; [
		hyprsplit
		hyprspace
		hyprscrolling
		csgo-vulkan-fix
	];
	settings = {
	};
     };



#     #Temp until wiki explaining new windowrules becomes clearer / updated
#     programs.hyprland = {
#         enable = true;
#         xwayland.enable = true;
#         withUWSM = true;
#     };


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
        ironbar
        nwg-panel
        nwg-drawer
    ];







}
