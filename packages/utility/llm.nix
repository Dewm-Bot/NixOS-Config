{ config, pkgs, inputs, lib, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };

  # Workaround for upstream llama.cpp webui build: writeBrandFavicons() copies
  # read-only SVGs from /nix/store into static/ and then fails with EACCES on
  # the second invocation (pwa-assets-dark.config.ts).
  llamaVulkan = inputs.llama-cpp.packages.${pkgs.system}.vulkan.overrideAttrs (old: {
    webui = old.webui.overrideAttrs (oldWebui: {
      postPatch = (oldWebui.postPatch or "") + ''
        substituteInPlace scripts/brand-favicons.ts \
          --replace-fail "import { copyFileSync, mkdirSync } from 'node:fs';" \
                         "import { chmodSync, copyFileSync, mkdirSync } from 'node:fs';" \
          --replace-fail "copyFileSync(require.resolve(specifier), resolve(outDir, fileName));" \
                         "const dest = resolve(outDir, fileName); copyFileSync(require.resolve(specifier), dest); chmodSync(dest, 0o644);"
      '';
    });
  });
in
{
  environment.systemPackages = with pkgs; [
    llamaVulkan
    lmstudio
    sillytavern
    ramalama
    opencode
    antigravity-cli
    antigravity-ide
    litellm
    inputs.hermes-agent.packages.${pkgs.system}.default
    ollama-vulkan
    stable-diffusion-cpp-vulkan
    koboldcpp
    claude-code
  ];
}
