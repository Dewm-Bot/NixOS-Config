{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        font-awesome
        nerd-fonts.fira-code
        noto-fonts-color-emoji
        noto-fonts
        noto-fonts-cjk-sans
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        liberation_ttf
    ];

    fonts.fontDir.enable = true;
}

