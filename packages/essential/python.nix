{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pandas
      requests
      numpy
      python-uinput
      evdev
      uv
    ]))
  ];

}

