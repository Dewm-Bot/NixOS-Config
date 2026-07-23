{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    uv
    nodeenv
    (python3.withPackages (ps: with ps; [
      pandas
      requests
      numpy
      python-uinput
      evdev
    ]))
  ];

}

