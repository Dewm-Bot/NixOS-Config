{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gamemode
        openspades
        latencyflex-vulkan
    ];
}


