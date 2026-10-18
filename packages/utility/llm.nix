{ config, pkgs, inputs, lib, ... }:
let
  aider-with-extras = inputs.aider-chat.packages.${pkgs.system}.passthru.withOptional {
    withPlaywright = true;
    withHelp = true;
    withBrowser = true;
  };

  llamaVulkan = inputs.llama-cpp.packages.${pkgs.system}.vulkan;
  rawLlamaRocm = inputs.llama-cpp.packages.${pkgs.system}.rocm;

  kernelAnvilPkg = pkgs.python312Packages.buildPythonApplication {
    pname = "kernel-anvil";
    version = "0.1.0";
    format = "pyproject";

    src = inputs.kernel-anvil;

    nativeBuildInputs = with pkgs.python312Packages; [
      setuptools
      wheel
    ];

    propagatedBuildInputs = with pkgs.python312Packages; [
      numpy
      torch
      rich
      gguf
      pkgs.rocmPackages.clr
      pkgs.rocmPackages.hipcc
      pkgs.rocmPackages.rocminfo
      pkgs.rocmPackages.rocm-smi
    ];

    makeWrapperArgs = [
      "--prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.rocmPackages.clr
        pkgs.rocmPackages.hipcc
        pkgs.rocmPackages.rocminfo
        pkgs.rocmPackages.rocm-smi
      ]}"
      "--prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        pkgs.rocmPackages.clr
      ]}"
      "--set ROCM_PATH ${pkgs.rocmPackages.clr}"
      "--set HIP_PATH ${pkgs.rocmPackages.clr}"
      "--set-default HSA_OVERRIDE_GFX_VERSION 12.0.1"
    ];

    doCheck = false;
  };

  llamaRocmPatched = rawLlamaRocm.overrideAttrs (oldAttrs: {
    cmakeFlags = (lib.filter (flag: !(lib.hasPrefix "-DCMAKE_HIP_ARCHITECTURES" flag)) (oldAttrs.cmakeFlags or [ ])) ++ [
      "-DCMAKE_HIP_ARCHITECTURES=gfx1201"
      "-DAMDGPU_TARGETS=gfx1201"
    ];

    postPatch = (oldAttrs.postPatch or "") + ''
      echo "=== Applying kernel-anvil smithy integration ==="

      mkdir -p ggml/src/ggml-cuda ggml/src/ggml-hip
      cp ${inputs.kernel-anvil}/patches/smithy-config.h ggml/src/ggml-cuda/
      cp ${inputs.kernel-anvil}/patches/smithy-config.h ggml/src/ggml-hip/

      if patch -p1 --dry-run < ${inputs.kernel-anvil}/patches/mmvq-smithy.patch >/dev/null 2>&1; then
        echo "Applying mmvq-smithy.patch..."
        patch -p1 < ${inputs.kernel-anvil}/patches/mmvq-smithy.patch
      elif patch -p1 --dry-run < ${inputs.kernel-anvil}/patches/mmvq-smithy-pre-gb10.patch >/dev/null 2>&1; then
        echo "Applying mmvq-smithy-pre-gb10.patch..."
        patch -p1 < ${inputs.kernel-anvil}/patches/mmvq-smithy-pre-gb10.patch
      else
        echo "ERROR: Neither mmvq patch applies cleanly!"
        exit 1
      fi

      for p in arg-h-smithy-router.patch arg-cpp-smithy-router.patch server-models-cpp-smithy-router.patch; do
        echo "Applying $p..."
        patch -p1 < "${inputs.kernel-anvil}/patches/$p"
      done
    '';
  });

  llama-cpp-rocm-wrapped = pkgs.symlinkJoin {
    name = "llama-cpp-rocm-wrapped";
    paths = [ llamaRocmPatched ];
    postBuild = ''
      for f in $out/bin/*; do
        mv "$f" "$out/bin/$(basename "$f")-rocm"
      done
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    kernelAnvilPkg             # <-- Global kernel-anvil CLI
    llama-cpp-rocm-wrapped     # <-- Global patched llama-server-rocm
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
