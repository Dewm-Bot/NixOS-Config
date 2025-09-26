{ config, pkgs, inputs, ... }:

let
  mpvScripts = [  #Define scripts for MPV here
    pkgs.mpvScripts.mpris
    pkgs.mpvScripts.modernx
    pkgs.mpvScripts.videoclip
  ];


in {
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = mpvScripts; #Apply scripts overlay
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    feishin
    mpv
    mpvpaper
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.obs-3d-effect
      obs-studio-plugins.wlrobs
      obs-studio-plugins.waveform
      obs-studio-plugins.obs-tuna
      obs-studio-plugins.obs-webkitgtk
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.input-overlay
    ];
  };
}
