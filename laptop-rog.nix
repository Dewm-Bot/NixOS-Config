{ config, pkgs, ... }:

{
    boot.kernelParams = [
        "i915.enable_dpcd_backlight=1"
        "nvidia-drm.modeset=1"
        "nvidia-drm.fbdev=1"
	"nova.disable=1"
        "nvidia.NVreg_RegistryDwords=RMUseSwI2c=0x01"
    ];

    hardware.nvidia.modesetting.enable = true;
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [ pkgs.pciutils ];

    services = {
        asusd = {
            enable = true;
            enableUserService = true;
        };
    };

    boot.blacklistedKernelModules = [
        "nova"
	"nova_core"
        "nova_drm"
    ];

    #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}


