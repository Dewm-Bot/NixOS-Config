{ config, pkgs, lib, ... }:

{

fileSystems."/run/media/Meiko" = {
  device = "Meiko";
  fsType = "zfs";
  options = [ 
    "nofail" 
    "X-mount.mkdir" 
  ];
};

  fileSystems."/run/media/Linux" = {
    device = "UUID=7A14A0D714A09821";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "windows_names"
      "ignore_cases"
      "rw"
      "user"
      "exec"
      "umask=000"
    ];
  };

  fileSystems."/run/media/Lighthouse" = {
    device = "UUID=01D85C55AD7919C0";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "defaults"
      "windows_names"
      "noatime"
      "nodiratime"
      "users"
      "exec"
      "rw"
      "umask=000"
    ];
  };

  fileSystems."/run/media/LoopSpinner" = {
    device = "UUID=7dd19ea0-61d2-4606-8e86-8c21d054be61";
    fsType = "btrfs";
    options = [
      "noatime"
      "lazytime"
      "commit=30"
      "nodiscard"
      "compress=zstd"
      "space_cache=v2"
      "nofail"
    ];
  };

  fileSystems."/run/media/Korekushon" = {
    device = "UUID=768EB6868EB63F05";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "defaults"
      "windows_names"
      "ignore_cases"
      "rw"
      "noatime"
      "user"
      "exec"
      "umask=000"
    ];
  };

  fileSystems."/run/media/dewm/Uchu" = {
    device = "UUID=96e6e9bb-5a82-4acf-a56a-6a13ea31af84";
    fsType = "btrfs";
    options = [
      "noatime"
      "lazytime"
      "commit=30"
      "nodiscard"
      "compress=zstd"
      "space_cache=v2"
      "nofail"
    ];
  };

  fileSystems."/run/media/Azami" = {
    device = "UUID=D87876357876128C";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "windows_names"
      "ignore_cases"
      "rw"
      "user"
      "exec"
      "umask=000"
    ];
  };
}
