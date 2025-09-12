{ config, pkgs, ... }:

{
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];

    environment.systemPackages = with pkgs; [
        clinfo
        lact
        amdvlk
        btop-rocm
        mesa
    ];

    #chaotic.mesa-git.enable = true;

    systemd.packages = with pkgs; [
        lact    
    ];

    systemd.services.lactd.wantedBy = ["multi-user.target"];

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };

        amdgpu.amdvlk = {
            enable = true;
            support32Bit.enable = true;
        };
    };

    #possible HIP library import
    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

}




