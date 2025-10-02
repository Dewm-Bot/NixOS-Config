{ config, pkgs, inputs, ... }:

let
  myV4L2Labels = "VirtualCam,ElgatoLoop";
  i686 = pkgs.pkgsi686Linux;  #32 bit helper???
in
{
  nixpkgs.overlays = [
    (self: super: {
      # Override obs-studio so pkgs.obs-studio uses cudaSupport
      obs-studio = super.obs-studio.override {
        cudaSupport = true;
      };
    })
  ];

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


    plugins = with pkgs.obs-studio-plugins; [
      obs-3d-effect
      wlrobs
      waveform
      obs-tuna
      obs-vkcapture
      input-overlay
      obs-vaapi
      obs-gstreamer
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # Kernel modules (v4l2 loopback, USB webcam driver, and audio-over-usb)
  boot.kernelModules = [
    "v4l2loopback"     # virtual cameras
    "uvcvideo"         # USB Video Class driver (common USB capture devices)
    "videodev"         # core v4l compatibility
    "snd-usb-audio"    # sound from USB capture devices (if device provides audio)
  ];

  # Module options for v4l2loopback (device numbers, labels, exclusive caps)
  boot.extraModprobeConfig = ''
    options v4l2loopback video_nr=10,11 card_label=${myV4L2Labels} exclusive_caps=1,max_buffers=2
  '';

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  # --- udev rules to ensure /dev/video* and /dev/dri/renderD* are group=video and accessible ---
  services.udev.extraRules = ''
    # v4l devices: /dev/video0 etc.
    KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", MODE="0660", GROUP="video"
    # render nodes (VA-API): /dev/dri/renderD* etc.
    KERNEL=="renderD*", SUBSYSTEM=="drm", MODE="0660", GROUP="video"
  '';

 #User group setup
  users.users.dewm= {
    extraGroups = [ "video" "audio" ];
  };

}

