{ config, pkgs, ... }:
let
  i686 = pkgs.pkgsi686Linux;    # 32-bit package set
in
{
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];

    environment.systemPackages = with pkgs; [
        clinfo
        lact
        #amdvlk
        btop-rocm
        mesa
        vulkan-loader
     ];

    #++ [  #Seperate runner for AMDVLK
    #(pkgs.writeShellScriptBin "amdvlk-run" ''
    #    export VK_ICD_FILENAMES="${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json:${i686.amdvlk}/share/vulkan/icd.d/amd_icd32.json"
    #    exec "$@"
    #'')
    #];

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
    };

    #possible HIP library import
    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];


    #CAP_SYS_NICE Patch
    boot.kernelPatches = [
    {
        name = "amdgpu-ignore-ctx-privileges";
        patch = pkgs.fetchpatch {
            name = "cap_sys_nice_begone.patch";
            url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
            hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
        };
    }
    ];


}




