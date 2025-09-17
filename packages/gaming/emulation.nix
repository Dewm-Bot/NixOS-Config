{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        #emulationstation-de
        pegasus-frontend
        xemu
        xdvdfs-cli
        pcsx2
        rpcs3
        dolphin-emu
        retroarch-full
        retroarch-assets
        retroarch-joypad-autoconfig
        librashader
        libretro-shaders-slang
        flycast
        cemu
        ryubing
        xenia-canary
        dosbox-x
        ppsspp
        melonDS
    ];
}


