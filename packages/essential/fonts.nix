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
        corefonts
        dm-mono
        fira-mono
        dejavu_fonts
        hack-font
    ];

    fonts.enableDefaultPackages = true;
    fonts.fontDir.enable = true;
    fonts.fontconfig.enable = true;    
}

