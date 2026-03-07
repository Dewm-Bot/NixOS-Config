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


    #UDEV Rules

    services.udev.extraRules = ''
    # Logitech Attack 3
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c214", TAG+="uaccess"

    # Logitech Extreme 3D Pro
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c215", TAG+="uaccess"

    # Saitek AV8r (Aviator)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="06a3", ATTRS{idProduct}=="0460", TAG+="uaccess"

    # Catch-all for other HID joysticks if the above IDs differ slightly
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{bInterfaceClass}=="03", ATTRS{bInterfaceProtocol}=="00", TAG+="uaccess"
    '';
}


