{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        fishPlugins.done
        fishPlugins.fzf-fish
        fishPlugins.forgit
        fishPlugins.hydro
        fzf
        fishPlugins.grc
        grc
        starship
        fish
        fastfetch
    ];

    programs.fish.enable = true;
    programs.starship.enable = true;

}


