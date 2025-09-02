{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        github-desktop
        gh
        gh-s
        git-hub
        gitnr
    ];


}


