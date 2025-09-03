{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bluez
    ];
}


