{ config, pkgs, ... }:

{
        # Enable the OpenSSH daemon.
    services.openssh = {
        enable = true;
        ports = [ 3419];
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ "dewm" ];
        };
    };

    services.fail2ban.enable = false;

}
