{ config, pkgs, inputs, ... }:
{
    #Okay, so if no matter what you do, gamescope isn't working. Toss in this junk:
    #env -u LD_PRELOAD /run/current-system/sw/bin/gamescope -- env LD_PRELOAD="$LD_PRELOAD" %command%

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        dedicatedServer.openFirewall = true;
        remotePlay.openFirewall = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];
        extraPackages = [
            pkgs.gamemode
            pkgs.jdk 
            pkgs.mangohud 
            pkgs.libkrb5 
            pkgs.keyutils
            pkgs.nss
            pkgs.nspr
            pkgs.dbus
        ];
    };

  services.udev.packages = [
    pkgs.game-devices-udev-rules
  ];

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        libxcb
        steamcmd
        inputs.sls-steam.packages.${pkgs.system}.wrapped
        protonplus
        evtest
        sdl-jstest
        linuxConsoleTools
        interception-tools
        umu-launcher
        goldberg-emu
        mangohud
        sgdboop
        winetricks
	inputs.prefixer.packages.${pkgs.system}.default
        gamescope-wsi
	me3
    ];

    programs.gamescope =
    {
        enable = true;
        capSysNice = false;
    };


   hardware.xone.enable = false;

    programs.java.enable = true;

    hardware.steam-hardware.enable = true;

    boot.kernelModules = [ "uinput" ];
}


