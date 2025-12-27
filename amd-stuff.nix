{ config, pkgs, ... }:

{
    boot.initrd.kernelModules = [ "amdgpu" ];

    chaotic.mesa-git.enable = true;
    chaotic.mesa-git.extraPackages = [
        pkgs.rocmPackages.clr.icd  # OpenCL support
    ];
    
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            libva
            libva-vdpau-driver
            rocmPackages.clr.icd
            intel-media-driver
        ];
    };

    hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];

    hardware.amdgpu.initrd.enable = true;

    # Force RADV (Radeon Vulkan) by default
#     environment.variables = {
#         "AMD_VULKAN_ICD" = "RADV";
#         # Force VAAPI to use the Mesa driver
#         "LIBVA_DRIVER_NAME" = "radeonsi";
#         "LIBVA_DRIVERS_PATH" = "/run/opengl-driver/lib/dri";
#     };

    environment.systemPackages = with pkgs; [
        clinfo
        lact
        btop-rocm
        libva-utils      # Run 'vainfo' to verify proper video encoding support
        vulkan-tools     # Run 'vulkaninfo' to verify Mesa-git version
        nvtopPackages.amd
        
        svt-av1
        libaom
        libvmaf
    ];

    # Daemon for LACT (GPU Tuning/Overclocking)
    systemd.packages = [ pkgs.lact ];
    systemd.services.lactd.wantedBy = ["multi-user.target"];

    # CAP_SYS_NICE Patch
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

    # HIP / ROCm fix
    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];


}
