{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        feishin
        mpv
        mpvpaper
        mpvScripts.mpris
        mpvScripts.modernx
        #mpvScripts.autosub
        mpvScripts.videoclip
        obs-studio
        obs-studio-plugins.obs-3d-effect
        obs-studio-plugins.wlrobs
        obs-studio-plugins.waveform
        obs-studio-plugins.obs-tuna
        obs-studio-plugins.obs-webkitgtk
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.input-overlay
        mpdris2
        mpd
        mpd-notification
        cantata
        inori
        ashuffle
        rofi-mpd
        yt-dlp
        radiotray-ng
        ncmpcpp
        rmpc
        kitty-img
    ];

}


