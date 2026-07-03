{ config, pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    x265
    nv-codec-headers
    v4l2-relayd
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    ffmpeg
    v4l-utils
    libv4l
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    # optional Nvidia hardware acceleration
#     package = (
#       pkgs.obs-studio.override {
#         cudaSupport = true;
#       }
#     );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
      input-overlay
      obs-tuna
      waveform
      obs-vintage-filter
    ];
  };

  # Discord fix (for device as capture only)
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  # Polkit is often required for OBS to successfully start the virtual device
  security.polkit.enable = true;

  # Kernel modules (v4l2 loopback, USB webcam driver, and audio-over-usb)
  boot.kernelModules = [
    "uvcvideo"         # USB Video Class driver (common USB capture devices)
    "videodev"         # core v4l compatibility
    "snd-usb-audio"    # sound from USB capture devices (if device provides audio)
    "snd-aloop"
  ];

  # User group setup
  users.users.dewm = {
    extraGroups = [ "video" "audio" ];
  };

}
