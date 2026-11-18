#!/usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
export TMPDIR=/run/media/LoopSpinner/Nix-Build/fake-tmp
export TMP=/run/media/LoopSpinner/Nix-Build/fake-tmp

set -o pipefail

# Locate nom (nix-output-monitor)
if command -v nom >/dev/null 2>&1; then
    NOM_BIN="nom"
elif [ -x /run/current-system/sw/bin/nom ]; then
    NOM_BIN="/run/current-system/sw/bin/nom"
else
    NOM_BIN="nix run --inputs-from /etc/nixos nixpkgs#nix-output-monitor --"
fi

nixos-rebuild switch --flake /etc/nixos/#DewmBox-Nix --impure \
  --option substituters "https://cache.nixos.org https://nyx-cache.chaotic.cx/ https://nix-citizen.cachix.org https://nix-gaming.cachix.org https://hyprland.cachix.org https://wvhulle.cachix.org" \
  --option connect-timeout 5 \
  --log-format internal-json -v "$@" |& $NOM_BIN --json
#nh clean all -k 4 
