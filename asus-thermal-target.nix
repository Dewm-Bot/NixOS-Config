{ config, lib, pkgs, ... }:
{
  # Load ASUS platform driver in initrd so thermal target is set before NVIDIA driver loads
  boot.initrd.kernelModules = [ "asus_nb_wmi" ];

  # Set GPU thermal target to 87°C in initrd via systemd service (systemd stage 1)
  boot.initrd.systemd.services.asus-thermal-target = {
    description = "Set ASUS GPU thermal target to 87°C";
    after = [ "sysinit.target" ];
    before = [ "initrd-switch-root.target" ];
    wantedBy = [ "initrd.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = [ "/bin/sh -c 'for i in {1..30}; do [[ -f /sys/devices/platform/asus-nb-wmi/nv_temp_target ]] && exit 0; sleep 0.1; done; exit 1'" ];
      ExecStart = "/bin/sh -c 'echo 87 > /sys/devices/platform/asus-nb-wmi/nv_temp_target && echo \"Set GPU thermal target to 87°C in initrd\"'";
      RemainAfterExit = true;
    };
  };
}
