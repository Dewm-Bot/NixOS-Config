{ config, pkgs, inputs, lib, llama-cpp, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };
in
{
    environment.systemPackages = with pkgs; [
        lmstudio
        sillytavern
        aichat
        ramalama
        #llama-cpp-vulkan
        inputs.llama-cpp.packages.${pkgs.system}.vulkan
        opencode
        antigravity-cli
        antigravity
        litellm
        inputs.hermes-agent.packages.${pkgs.system}.default
        ollama-vulkan
        aider-chat
    ];
}


