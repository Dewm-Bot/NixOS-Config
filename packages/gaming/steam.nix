{ config, pkgs, ... }:

{


    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];
        extraPackages = [ pkgs.gamemode ];
    };

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        xorg.libxcb
        steamcmd
        jovian-chaotic.gamescope-wsi
        jovian-chaotic.gamescope-session
    ];

    programs.gamescope =
    {
        enable = true;
        capSysNice = true;
    };

    hardware.xone.enable = true;

    programs.java.enable = true;

    hardware.steam-hardware.enable = true;



}


