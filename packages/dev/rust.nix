{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        cargo
        rustup
    ];
}


