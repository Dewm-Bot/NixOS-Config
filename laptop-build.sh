[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
nixos-rebuild switch --flake /etc/nixos/#DewmM16-Nix
nh clean all -k 4 
