{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        tree
        git
        wget
        vulkan-tools
        nix-search-cli
        
    ];
}


