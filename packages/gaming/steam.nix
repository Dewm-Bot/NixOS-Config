{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        steam
        steamtinkerlaunch
    ];
    
        programs.steam.enable = true;

}


