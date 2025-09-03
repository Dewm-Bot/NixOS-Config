{ config, pkgs, ... }:

{
    hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];

    environment.systemPackages = with pkgs; [
        clinfo
        lact
        mesa
        amdvlk
        btop-rocm
    ];

    systemd.packages = with pkgs; [
        lact    
    ];

    systemd.services.lactd.wantedBy = ["multi-user.target"];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };




}


