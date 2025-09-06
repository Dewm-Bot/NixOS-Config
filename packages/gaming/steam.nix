{ config, pkgs, ... }:

{

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        xorg.libxcb
        steamcmd
    ];
    programs.steam.extraPackages = [ pkgs.gamemode ];
    programs.gamescope =
    {
        enable = true;
        capSysNice = true;
    };

    hardware.xone.enable = true;

    programs.java.enable = true;

    hardware.steam-hardware.enable = true;



}


