{ config, pkgs, inputs, lib, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.stdenv.hostPlatform.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };

  llamaVulkan = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.vulkan;
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
    antigravity-ide
    # litellm
    inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default
    ollama-vulkan
    # aider-chat
    stable-diffusion-cpp-vulkan
    koboldcpp
    claude-code
  ];
}
