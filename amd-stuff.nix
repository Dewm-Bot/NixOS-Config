{ config, pkgs, ... }:

{
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = [
            pkgs.rocmPackages.clr.icd  # OpenCL support
            #pkgs.amdvlk                # Optional: Keep ONLY if you need to swap to it for specific games
        ];
    };

    # Force RADV (Radeon Vulkan) by default
    # RADV (Mesa) generally outperforms AMDVLK in gaming.
    environment.variables = {
        "AMD_VULKAN_ICD" = "RADV";
    };

    # System Packages
    environment.systemPackages = with pkgs; [
        clinfo
        lact
        btop-rocm
        libva-utils      # For verifying VAAPI (vainfo)
        vulkan-tools     # For verifying Vulkan (vulkaninfo)
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
