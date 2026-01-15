{ config, pkgs, inputs, ... }:
{
    environment.systemPackages = with pkgs; [
        inputs.nix-citizen.packages.${system}.rsi-launcher-umu
    ];
}



