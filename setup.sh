[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
nixos-rebuild dry-run
nixos-rebuild switch --flake /etc/nixos/#DewmBox-Nix
