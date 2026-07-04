{ config, pkgs, lib,  ... }:

{
    boot.kernelParams = [
        "i915.enable_dpcd_backlight=1"
        "nvidia-drm.modeset=1"
        "nvidia-drm.fbdev=1"
        "nova.disable=1"
        "nvidia.NVreg_RegistryDwords=RMUseSwI2c=0x01"
        "nvidia.NVreg_EnableS0ixPowerManagement=1"
	"nvidia.NVreg_EnableGpuFirmware=1"
    ];

    hardware.nvidia.modesetting.enable = true;
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [ pkgs.pciutils ];

    boot.blacklistedKernelModules = [
        "nova"
        "nova_core"
        "nova_drm"
    ];

    services.asusd.enable = true;

    services.tlp.enable = false;

    boot.kernel.sysctl = { 
        "vm.watermark_boost_factor" = 0;
        "vm.watermark_scale_factor" = 125;
        "vm.dirty_bytes" = 268435456;
        "vm.dirty_background_bytes" = 134217728;
        "vm.page-cluster" = 0;
    };

    
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];

    services.power-profiles-daemon.enable = false;

    hardware.nvidia.dynamicBoost.enable = true;

    systemd.services.nvidia-powerd = {
        after = [ "dbus.service" "display-manager.service" "asusd.service" ];
        requires = [ "asusd.service" ];
        serviceConfig = {
          Restart = "always";
          RestartSec = "2s";
        };
    };

    boot.extraModprobeConfig = ''
        options snd-hda-intel model=alc285-asus power_save=0 power_save_controller=N
    '';

    #Ugly solution to give AsusCTL / AsusD PPD "Support"

    services.tuned = {
      enable = false;
      ppdSupport = true; #hijack PPD

      #Locaiton for our dummy profiles
      settings.profile_dirs = "/etc/tuned/";

    # Generate the dummy profiles
    # These profiles do absolutely nothing except run a bash script to command asusd

    # We have to overwrite existing ones to beat race condition
    profiles = {
      "throughput-performance" = {
        main = { summary = "ASUS Performance Proxy"; };
        script = {
          script = "${pkgs.writeShellScript "asus-perf.sh" ''
            if [ "$1" = "start" ]; then
	      export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket
              ${pkgs.asusctl}/bin/asusctl profile set Performance
            fi
          ''}";
        };
      };

      "balanced" = {
        main = { summary = "ASUS Balanced Proxy"; };
        script = {
          script = "${pkgs.writeShellScript "asus-bal.sh" ''
            if [ "$1" = "start" ]; then
              export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket
              ${pkgs.asusctl}/bin/asusctl profile set Balanced
            fi
          ''}";
        };
      };

      "powersave" = {
        main = { summary = "ASUS Quiet Proxy"; };
        script = {
          script = "${pkgs.writeShellScript "asus-quiet.sh" ''
            if [ "$1" = "start" ]; then
              export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket
              ${pkgs.asusctl}/bin/asusctl profile set Quiet
            fi
          ''}";
        };
      };
    };

    #Assign our dummy profiles
    ppdSettings = {
      profiles = {
        performance = "throughput-performance";
        balanced    = "balanced";
        power-saver = "powersave";
        };
      };
  };

  systemd.services.tuned-ppd = {
    after = [ "tuned.service" ];
    requires = [ "tuned.service" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
    };
  };


}


