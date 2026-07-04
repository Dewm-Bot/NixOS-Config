{ config, pkgs, inputs, lib, ... }:
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
        ollama-vulkan
	aider-chat
	llama-cpp-vulkan
	opencode
	inputs.hermes-agent.packages.${pkgs.system}.default
    ];
}


