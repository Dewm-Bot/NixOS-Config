{ config, pkgs, inputs, lib, ... }:

{
    services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
    };

    security.wrappers.sunshine = {
        owner = "root";
        group = "root";
        #capabilities = "cap_sys_admin+p";
        source = "${pkgs.sunshine}/bin/sunshine";
    };

    services.avahi.settings.publish = {
        "disable-publishing" = false;
        disable-user-service-publishing = false;
        publish-addresses = true;
    };

    environment.systemPackages = with pkgs; [
        moonlight-qt
    ];
}


