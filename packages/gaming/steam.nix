{ config, pkgs, inputs, ... }:

{
    #Okay, so if no matter what you do, gamescope isn't working. Toss in this junk:
    #env -u LD_PRELOAD /run/current-system/sw/bin/gamescope -- env LD_PRELOAD="$LD_PRELOAD" %command%

    programs.steam = {
        enable = true;
        gamescopeSession.enable = false;
        dedicatedServer.openFirewall = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
            proton-cachyos
        ];
        extraPackages = [ pkgs.gamemode pkgs.jdk pkgs.mesa-demos pkgs.bumblebee pkgs.mangohud ];
    };
    #programs.steam.package = pkgs.steam.override {
        #extraEnv = {
        #LD_AUDIT = "${inputs.sls-steam.packages.${pkgs.system}.sls-steam}/SLSsteam.so";
        #};
    #};

    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        gamemode
        xorg.libxcb
        steamcmd
        gamescope_git
        jovian-chaotic.gamescope-session
        inputs.sls-steam.packages.${pkgs.system}.wrapped
        protonplus
        steam-devices-udev-rules
        evtest
        #sdl-jstest
        linuxConsoleTools
        interception-tools
        sc-controller
        umu-launcher
        goldberg-emu
        sgdboop
	joycond
    ];

    programs.gamescope =
    {
        enable = true;
        capSysNice = true;
    };

   hardware.xone.enable = true;

    programs.java.enable = true;

    hardware.steam-hardware.enable = true;
    services.udev.packages = [ pkgs.steam-devices-udev-rules ];


    boot.kernelModules = [ "uinput" ];

    # make sure udev rules give the uinput node to the input group / uaccess
    services.udev.extraRules = ''
        # uinput
        KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"

        # NEW RULE: gamepad emulation (uinput) with broader permissions
        KERNEL=="uinput", MODE="0666", GROUP="users", OPTIONS+="static_node=uinput"

        # Valve HID devices over USB hidraw (idVendor 28de is Valve's)
        KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"

        # Valve HID devices over bluetooth hidraw
        KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
    '';




}


