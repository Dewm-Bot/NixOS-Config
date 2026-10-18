{ config, pkgs, inputs, lib, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };

  llamaVulkan = inputs.llama-cpp.packages.${pkgs.system}.vulkan;
in
{
  environment.systemPackages = with pkgs; [
    llamaVulkan
    lmstudio
    sillytavern
    aichat
    ramalama
    opencode
    antigravity-cli
    antigravity
    litellm
    inputs.hermes-agent.packages.${pkgs.system}.default
    ollama-vulkan
    aider-chat
    stable-diffusion-cpp-vulkan
    koboldcpp
    claude-code
  ];
}
