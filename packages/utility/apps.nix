{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        zed-editor
        uget
        
    ];

}


