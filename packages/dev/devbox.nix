{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        devbox
    ];

    #Gross, we have to actually accept a license agreement in our config...
    #android_sdk.accept_license = true;

    boot.kernel.sysctl = {
        "net.ipv4.ip_unprivileged_port_start" = 80;
    };
}


