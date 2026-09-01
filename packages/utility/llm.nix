{ config, pkgs, inputs, lib, llama-cpp, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };

  llamaVulkan = inputs.llama-cpp.packages.${pkgs.system}.vulkan;
  llamaRocm = inputs.llama-cpp.packages.${pkgs.system}.rocm;

  llama-cpp-rocm-wrapped = pkgs.symlinkJoin {
    name = "llama-cpp-rocm-wrapped";
    paths = [ llamaRocm ];
    postBuild = ''
      for f in $out/bin/*; do
        mv "$f" "$out/bin/$(basename "$f")-rocm"
      done
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    lmstudio
    sillytavern
    aichat
    ramalama
    llamaVulkan
    llama-cpp-rocm-wrapped
    opencode
    antigravity-cli
    antigravity
    litellm
    inputs.hermes-agent.packages.${pkgs.system}.default
    ollama-vulkan
    aider-chat
    stable-diffusion-cpp-vulkan
    comfyui
  ];
}
