{ config, pkgs, ... }:

{
  # Add udev rules for the Fanatec pedals
  services.udev.extraRules = ''
    # Rule to flag Fanatec pedals as a joystick AND keyboard to help SDL detection
    SUBSYSTEM=="input", ATTRS{idVendor}=="0eb7", ATTRS{idProduct}=="1a95", MODE="0666", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_KEY}="1", ENV{SDL_GAMECONTROLLER_NAME}="FANATEC ClubSport USB Pedal", TAG+="uaccess", TAG+="udev-acl"
    
    # Rule to ensure your user has permission to create virtual uinput devices
    KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"
  '';

  # Also ensure your user is in the 'input' group
  users.users.dewm.extraGroups = [ "input" ];

  # Make sure the uinput kernel module is loaded at boot
  boot.kernelModules = [ "uinput" ];


}

