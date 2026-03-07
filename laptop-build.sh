#!/usr/bin/env bash

# Check for root privileges and re-execute with sudo if needed
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# --- BUILD PHASE ---
echo "Building and switching to new NixOS configuration..."
nixos-rebuild switch --flake /etc/nixos/#DewmM16-Nix

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
echo "Running Nix store cleanup..."
/run/current-system/sw/bin/nh clean all -k 4

echo "NixOS Build for [DewmM16] has successfully completed."
