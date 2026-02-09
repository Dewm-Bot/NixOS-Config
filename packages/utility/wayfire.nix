{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        wayfire-with-plugins
        wf-config
        wayfirePlugins.wf-shell
        dms-shell
    ];
}

