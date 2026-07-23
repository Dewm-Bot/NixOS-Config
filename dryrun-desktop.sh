[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
nixos-rebuild build --flake /etc/nixos/#DewmBox-Nix --impure --keep-going
nh clean all -k 4 
