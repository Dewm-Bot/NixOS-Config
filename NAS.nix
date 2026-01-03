{ config, pkgs, lib, ... }:

{
    fileSystems."/run/media/NAS" = {
        device = "//10.254.254.251/Alex";
        fsType = "cifs";
        options = [
            "credentials=/etc/smb-credentials/nas"
            "uid=1000"
            "gid=1000"
            "x-systemd.automount"
            "noauto"
            "nofail"
            "users"
            "noperm"
            "iocharset=utf8"
            "vers=3.0"
            "dirmode=0777"
            "nounix"
            "_netdev"
        ];
    };
}

