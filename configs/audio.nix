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

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
  };

    services.pipewire.extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
            "default.clock.rate" = 48000;
            "default.allowed-rates" = [48000 192000];
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 256;
         };
         context.modules = [
         {
            name = "libpipewire-module-protocol-pulse";
            args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "64/48000";
            pulse.max.req = "256/48000";
            pulse.min.quantum = "64/48000";
            pulse.max.quantum = "256/48000";
            };
        }
        ];
            stream.properties = {
                node.latency = "32/48000";
                resample.quality = 1;
            }; 
    };

    environment.systemPackages = [
        pkgs.pavucontrol
    ];
}


