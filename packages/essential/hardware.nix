{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bluez
	xfsprogs
	xfs-undelete
	libxfs
	f2fs-tools
	dmidecode
	lshw
	lshw-gui
	smartmontools
	traceroute
	ethtool
	lsof
    ];
}


