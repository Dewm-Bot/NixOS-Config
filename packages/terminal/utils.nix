{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        eza
        cargo-nextest
        cargo-update
        beeper
        bat
        bacon
        anytype
        jless
        jq
        nodenv
    ];
}


