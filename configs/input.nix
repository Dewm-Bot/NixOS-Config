{ config, pkgs, ... }:

{
    #Raw mouse handler (possibly only x11)
    hardware.yeetmouse = {
        enable = true;
        sensitivity = 1.0;
    };
}


