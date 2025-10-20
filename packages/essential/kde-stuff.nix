{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        kdePackages.dolphin
        kdePackages.filelight
        kdePackages.kate
        kdePackages.kcmutils
        kdePackages.kwallet-pam
        kdePackages.kwalletmanager
        kdePackages.qt5compat
        kdePackages.kio-admin
    ];
}


