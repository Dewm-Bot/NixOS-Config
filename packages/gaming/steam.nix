{ config, pkgs, ... }:

{


    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
            proton-cachyos
        ];
        extraPackages = [ pkgs.gamemode ];
    };

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        xorg.libxcb
        steamcmd
        gamescope_git
        jovian-chaotic.gamescope-session
        mangohud_git
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


