{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        font-awesome
        nerd-fonts.fira-code
        noto-fonts-emoji
    ];
}

