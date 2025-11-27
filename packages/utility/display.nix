{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        ddcutil
        ddcui
        wlsunset
        gammastep
        wl-gammactl
    ];

}
