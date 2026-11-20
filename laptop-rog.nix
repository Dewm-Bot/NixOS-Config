{ config, pkgs, lib,  ... }:

{
    boot.kernelParams = [
        "i915.enable_dpcd_backlight=1"
        "nvidia-drm.modeset=1"
        "nvidia-drm.fbdev=1"
        "nova.disable=1"
        "nvidia.NVreg_RegistryDwords=RMUseSwI2c=0x01"
    ];

    hardware.nvidia.modesetting.enable = true;
    hardware.graphics.enable32Bit = true;
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [ pkgs.pciutils ];

    # Load NVIDIA DRM modules in Stage 2 (after initrd asus-thermal-target)
    # so card2/fb0 is ready before SDDM starts.
    boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

    boot.blacklistedKernelModules = [
        "nova"
        "nova_core"
        "nova_drm"
        "nouveau"
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

    hardware.nvidia.prime = {
       offload = {
          enable = true;
          enableOffloadCmd = true;
    };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
    };

    
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];

    services.power-profiles-daemon.enable = false;

    hardware.nvidia.dynamicBoost.enable = true;

    boot.extraModprobeConfig = ''
        options snd-hda-intel power_save=0 power_save_controller=N
    '';

    #Ugly solution to give AsusCTL / AsusD PPD "Support"
services.tuned = {
    enable = true;
    ppdSupport = true;
    settings.profile_dirs = "/etc/tuned/";

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

    ppdSettings = {
      profiles = {
        performance = "throughput-performance";
        balanced    = "balanced";
        power-saver = "powersave";
      };
    };
  };

  systemd.services.tuned-ppd = {
    after = [ "tuned.service" "asusd.service" ];
    requires = [ "tuned.service" ];
  };

  # Upstream asusd.service already declares After=nvidia-powerd.service, so
  # ordering nvidia-powerd after asusd creates a boot-time cycle that causes
  # systemd to drop asusd.service. Instead, keep the boot DAG acyclic and
  # refresh nvidia-powerd once asusd and tuned-ppd have finished applying the
  # Performance ACPI table.
  systemd.services.nvidia-powerd = {
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
    };
  };

  systemd.services.nvidia-powerd-refresh = {
    description = "Restart nvidia-powerd after asusd and tuned-ppd apply ACPI tables";
    after = [ "asusd.service" "tuned-ppd.service" "nvidia-powerd.service" ];
    wants = [ "asusd.service" "tuned-ppd.service" "nvidia-powerd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl try-restart --no-block nvidia-powerd.service";
    };
  };

  # Keep bootvine active until Stage 2 finishes, then stop it synchronously so
  # it cannot yank the active VT back to tty12 while SDDM/labwc claim VT 1.
  systemd.services.display-manager.serviceConfig.ExecStartPre = lib.mkIf config.services.bootvine.enable [
    "-${pkgs.systemd}/bin/systemctl stop bootvine.service"
  ];

}


