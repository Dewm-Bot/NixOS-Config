{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        monitor
        resources
    ];
}


