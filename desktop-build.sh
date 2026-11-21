#!/usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
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
  --accept-flake-config \
  --log-format internal-json -v "$@" |& $NOM_BIN --json

 # Check if the rebuild worked
if [ $? -ne 0 ]; then
    echo "NixOS Failed to build, aborting signing..."
    exit 1
fi

# --- SIGNING PHASE ---

# Define the SBCTL path
SBCTL_BIN="/run/current-system/sw/bin/sbctl"

# Define which directories you'd like to scan for EFI files
BOOT_DIRS=(
    "/boot/EFI/BOOT"
    "/boot/EFI/Linux"
    "/boot/EFI/systemd"
    "/boot/EFI/refind"
    "/boot/EFI/nixos"
)

echo "Initializing SBCTL and signing all relevant .efi files..."

# EFI Sign Loop
for dir in "${BOOT_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Scanning directory: $dir"

        # Find all EFI files (single-depth)
        find "$dir" -maxdepth 1 -type f -iname "*.efi" | while read efi_file; do
            echo "Signing $efi_file..."
            # Sign each file
            "$SBCTL_BIN" sign -s "$efi_file"
        done
    else
        echo "Warning: Directory not found at $dir. Skipping."
    fi
done

# --- CLEANUP PHASE ---
nh clean all -k 4
