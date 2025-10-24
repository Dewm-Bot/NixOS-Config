{ config, pkgs, ... }:

{
  boot.kernelParams = [ "preempt=full" ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."91-sunshine-sink" = {
      "context.objects" = [
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "sunshine-virtual-sink"; # The name you'll use in Sunshine
            "node.description" = "Sunshine Virtual Audio Sink";
            "media.class" = "Audio/Sink";
            "audio.position" = "FL,FR";
            "node.latency" = "256/48000";
          };
        }
      ];
    };
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.allowed-rates" = [48000 192000];
      "default.clock.quantum" = 128;
      "default.clock.min-quantum" = 128;
      "default.clock.max-quantum" = 512;
     };
     context.modules = [
     {
        name = "libpipewire-module-protocol-pulse";
        args = {
        pulse.min.req = "128/48000";
        pulse.default.req = "128/48000";
        pulse.max.req = "512/48000";
        pulse.min.quantum = "128/48000";
        pulse.max.quantum = "512/48000";
        };
      }
      ];
      stream.properties = {
        node.latency = "128/48000";
        resample.quality = 1;
      }; 
  };

  environment.systemPackages = [
    pkgs.pavucontrol
    pkgs.pulseaudio
  ];
}
