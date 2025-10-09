{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        tuir
        tuisky
        tui-journal
        tuifimanager
        so
        dooit
        cl-wordle
        bluetui
        youtube-tui
        systemctl-tui
        gitu
        xplr
        termusic
        lazycli
        airgeddon
        tran
        smassh
        play
        nix-inspect
        wiki-tui
        tray-tui
        s-tui
        md-tui
        manga-tui
        chawan
        pokete
        nbsdgames
        ollama-cuda
        oterm
    ];


}
