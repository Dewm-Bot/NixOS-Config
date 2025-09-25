{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        uget
        onlyoffice-desktopeditors
        bottles
    ];

}


