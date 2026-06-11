{ pkgs, inputs, deviceType, ... }:

{
    imports = []
    ++ (if deviceType == "desktop" then [ ./hyprland.nix ] else [ ]);
}

