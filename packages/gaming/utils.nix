{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode
    openspades
    input-remapper
    libinput
    xpad
  ];


hardware.bluetooth.settings = {
    Input = {
      # Allow gamepads to connect without strict bonding
      ClassicBondedOnly = false;
      
      # Optional but highly recommended for Nintendo controllers
      UserspaceHID = true; 
    };
  };

boot.kernelModules = [ "xpad" ];
#boot.extraModulePackages = with config.boot.kernelPackages; [ xpad ];

services.udev.extraRules = ''
  # EasySMX X20 2.4GHz Dongle (ZhiXu / Xbox 360 spoof)
  SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="028e", MODE="0666", GROUP="input"
  
  # Ensure uinput is accessible for Steam
  KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess", GROUP="input", MODE="0660"

  # Give Steam direct rw access to Nintendo Switch Pro Controllers over Bluetooth
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0666", GROUP="input"
'';
}

