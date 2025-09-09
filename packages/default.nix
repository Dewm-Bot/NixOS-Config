{ pkgs, inputs, ... }: 

{
    imports = [
        ./essential
        ./communication
        ./terminal
        ./gamedev
        ./gaming
        ./hyprland
        ./dev
    ];
}

