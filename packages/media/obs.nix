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
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
      obs-backgroundremoval
      input-overlay
      obs-tuna
      waveform
      obs-vintage-filter
    ];
  };



  # Module options for v4l2loopback (device numbers, labels, exclusive caps)
#   boot.extraModprobeConfig = ''
#     options v4l2loopback video_nr=10,11 card_label=${myV4L2Labels} exclusive_caps=1,max_buffers=2
#   '';

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

    # Kernel modules (v4l2 loopback, USB webcam driver, and audio-over-usb)
  boot.kernelModules = [
    #"v4l2loopback"     # virtual cameras (Should be included by enableVirtualCamera)
    "uvcvideo"         # USB Video Class driver (common USB capture devices)
    "videodev"         # core v4l compatibility
    "snd-usb-audio"    # sound from USB capture devices (if device provides audio)
    "snd-aloop"
  ];


#   # --- udev rules to ensure /dev/video* and /dev/dri/renderD* are group=video and accessible ---
#   services.udev.extraRules = ''
#     # v4l devices: /dev/video0 etc.
#     KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", MODE="0660", GROUP="video"
#     # render nodes (VA-API): /dev/dri/renderD* etc.
#     KERNEL=="renderD*", SUBSYSTEM=="drm", MODE="0660", GROUP="video"
#   '';



 #User group setup
  users.users.dewm= {
    extraGroups = [ "video" "audio" ];
  };

}

