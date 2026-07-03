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
    ncmpcpp
    rmpc
    kitty-img
    x265
    nv-codec-headers
  ];

}
