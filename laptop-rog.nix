{ config, pkgs, ... }:

{
    boot.kernelParams = [
        "i915.enable_dpcd_backlight=1"
        "nvidia.NVreg_EnableBacklightHandler=0"
    ];
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [ pkgs.pciutils ];

    services = {
        asusd = {
        enable = true;
        enableUserService = true;
        };
    };

    #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}


