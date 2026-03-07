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

    services.tlp.enable = false;

    services.tuned.enable = true;
    services.tuned.settings.daemon = true;
    services.tuned.ppdSupport = true;
    services.tuned.settings.profile_dirs = "/etc/tuned/";
    services.tuned.ppdSettings = {
        profiles = {
            balanced = "balanced-bazzite";
            performance = "throughput-performance-bazzite";
            power-saver = "powersave-bazzite";
        };
        battery = {
            balanced = "balanced-battery-bazzite";
            performance = "balanced-bazzite";
            power-saver = "powersave-battery-bazzite";
        };
        main = {
            default = "balanced";
            battery_detection = true;
        };
    };

    hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];
}


