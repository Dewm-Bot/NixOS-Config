{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        jetbrains.rider
        jetbrains.pycharm-community
        jetbrains.clion
        jetbrains.rust-rover
    ];
}
