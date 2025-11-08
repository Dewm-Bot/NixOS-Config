#!/usr/bin/env bash

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

#Build flake (DewmM16 in this case)
echo "Building and switching to new NixOS configuration..."
nixos-rebuild switch --flake /etc/nixos/#DewmM16-Nix

#Check if the rebuild worked
if [ $? -ne 0 ]; then
    echo "Nixos Failed to build, aborting..."
    exit 1
fi


#EFIs to sign
EFI_BOOT_MANAGER="/boot/EFI/BOOT/BOOTX64.EFI"
SYSTEMD_BOOT_BIN="/boot/EFI/systemd/systemd-bootx64.efi"

echo "Initializing SBCTL..."

#Find our SBCTL
SBCTL_BIN="/run/current-system/sw/bin/sbctl"

#Sign BOOTX64.EFI
if [ -f "$EFI_BOOT_MANAGER" ]; then
    echo "Signing $EFI_BOOT_MANAGER..."
    "$SBCTL_BIN" sign -s "$EFI_BOOT_MANAGER"
fi

# Sign systemd-boot
if [ -f "$SYSTEMD_BOOT_BIN" ]; then
    echo "Signing $SYSTEMD_BOOT_BIN..."
    "$SBCTL_BIN" sign -s "$SYSTEMD_BOOT_BIN"
fi

# Cleanup
echo "Running Nix store cleanup..."
/run/current-system/sw/bin/nh clean all -k 4

echo "NixOS Build for [DewmM16] has successfully completed."
