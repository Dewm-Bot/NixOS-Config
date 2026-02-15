{ config, pkgs, lib, ... }:

{

  fileSystems."/run/media/Meiko" = {
    device = "UUID=4583e2b1-74d5-429b-9cde-6890303f9c83";
    fsType = "btrfs";
    options = [
      "noatime"
      "lazytime"
      "commit=30"
      "nodiscard"
      "compress=zstd"
      "space_cache=v2"
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
    device = "UUID=98BE69AFBE69871A";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "defaults"
      "windows_names"
      "noatime"
      "nodiratime"
      "rw"
      "users"
      "exec"
      "umask=000"
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
