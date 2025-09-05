{ config, pkgs, ... }:

{
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [ pkgs.pciutils ];

    services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest; # Same as production
    
    
};
}


