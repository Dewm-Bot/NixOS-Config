{ config, pkgs, ... }:

{
    #Raw mouse handler 
    hardware.yeetmouse = {
        enable = true;
        sensitivity = 1.0;
    };

    services.libinput.enable = true;

#    hardware.xpadneo.enable = true;
#
#    boot = {
#    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
#    extraModprobeConfig = ''
#      options bluetooth disable_ertm=Y
#    '';
#  };

    hardware.xpad-noone.enable = false;
}


