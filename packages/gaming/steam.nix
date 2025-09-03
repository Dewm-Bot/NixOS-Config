{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        steam
        steamtinkerlaunch
    ];

    programs.steam.gamescopeSession.enable = true;
    programs.gamescope.enable = true;


}


