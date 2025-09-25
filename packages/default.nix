{ pkgs, inputs, ... }: 

{
    imports = [
        ./essential
        ./communication
        ./terminal
        ./gamedev
        ./gaming
        ./media
        ./hyprland
        ./dev
        ./utility
    ];
}

