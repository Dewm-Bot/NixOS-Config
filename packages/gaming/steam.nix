{ config, pkgs, inputs, ... }:

{
    #Okay, so if no matter what you do, gamescope isn't working. Toss in this junk:
    #env -u LD_PRELOAD /run/current-system/sw/bin/gamescope -- env LD_PRELOAD="$LD_PRELOAD" %command%

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
            proton-cachyos
        ];
        extraPackages = [ pkgs.gamemode pkgs.jdk pkgs.glxinfo pkgs.bumblebee pkgs.mangohud ];
    };

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        xorg.libxcb
        steamcmd
        gamescope_git
        jovian-chaotic.gamescope-session
        inputs.sls-steam.packages.${pkgs.system}.wrapped
    ];

    programs.gamescope =
    {
        enable = true;
        capSysNice = true;
    };

    hardware.xone.enable = true;

    programs.java.enable = true;

    hardware.steam-hardware.enable = true;

    services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-cpp;
        extraRules = [
            {
                "name" = "gamescope";
                "nice" = -20;
            }
        ];
        };

}


