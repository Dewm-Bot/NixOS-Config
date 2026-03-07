{ config, pkgs, inputs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        lmstudio
        sillytavern
        aichat
        ramalama
        local-ai
        ollama-vulkan
    ];



}


