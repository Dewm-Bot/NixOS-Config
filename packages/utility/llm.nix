{ config, pkgs, inputs, lib, llama-cpp, ... }:

{
    environment.systemPackages = with pkgs; [
        lmstudio
        sillytavern
        aichat
        ramalama
        #llama-cpp-vulkan
        inputs.llama-cpp.packages.${pkgs.system}.vulkan
        opencode
        gemini-cli-bin
        litellm
        inputs.hermes-agent.packages.${pkgs.system}.default
    ];



}


