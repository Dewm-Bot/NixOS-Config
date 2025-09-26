{ config, pkgs, inputs, ... }:

let
  mpvScripts = [  # Define scripts for MPV here
    pkgs.mpvScripts.mpris
    pkgs.mpvScripts.modernx
    pkgs.mpvScripts.videoclip
  ];
in {
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = mpvScripts; # Apply scripts overlay
      };

      # Override obs-studio in the overlay so pkgs.obs-studio uses cudaSupport
      obs-studio = super.obs-studio.override {
        cudaSupport = true;
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
    x265
    nv-codec-headers
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-3d-effect
      wlrobs
      waveform
      obs-tuna
      obs-webkitgtk
      obs-vkcapture
      input-overlay
      obs-vaapi
      obs-gstreamer
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.obs-studio.enableVirtualCamera = true;
}
